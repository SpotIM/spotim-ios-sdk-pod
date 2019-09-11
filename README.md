# Get Started

### To add Spot.IM iOS SDK to a project via CocoaPods:
1. Add Spot.IM spec repo to your system by running the following command in Terminal:  
  `pod repo add Spot.IM.Spec git@github.com:SpotIM/spotim-ios-sdk-pod.git`
2. Add spec sources at the top of the podfile:  
  `source 'git@github.com:SpotIM/spotim-ios-sdk-pod.git'`  
  `source 'https://github.com/CocoaPods/Specs.git'`  
3. Set dependency as follows: `pod 'Spot.IM-Core'`
4. Run the following command in Terminal:  
  `pod repo update Spot.IM.Spec`
4. Run the following command to make sure the framework is available via CocoaPods:  
  `pod search Spot.IM`  
5. Run pod install
6. Open workspace file and run

### Setup

To use the SDK you need to set your unique Spot ID key first. The recommended way to do it is in `application(application:didFinishLaunchingWithOptions)` function of App Delegate. 

##### Example

```swift
    func application(
      _ application: UIApplication, 
      didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        SPClientSettings.setup(spotKey: "YOUR UNIQUE SPOT ID")
        
        return true
    }
```

### Usage
End user is supposed to interact with the Pre-Conversation View Controller (PCVC) first. To get and instance of it, you need an instance of `SpotImSDKFlowCoordinator`:
```swift
spotIMCoordinator = SpotImSDKFlowCoordinator(delegate: self)
```
Make sure to have a strong reference, it will be deallocated otherwise.
Then you can instantiate PCVC for specific post (article) ID:
```swift
let preConversationVC = spotIMCoordinator?.preConversationController(
                          withPostId: "POST ID",
                          container: navigationController
                        )
```

PCVC's view should be added as a subview of a view of another view controller.

#### Adding Pre-Conversation VC

1. Add PCVC as a child of another VC
2. Add PCVC view to a view of another VC or a container view
3. Layout the PCVC view
4. Call `open func didMove(toParent parent: UIViewController?)` method of PCVC instance

##### Example

```swift
preConversationVC.view.translatesAutoresizingMaskIntoConstraints = false

addChild(preConversationVC)
containerView.addSubview(preConversationVC.view)

preConversationVC.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
preConversationVC.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
preConversationVC.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
preConversationVC.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true

preConversationVC.didMove(toParent: self)
```
##### ⚠️ IMPORTANT
Make sure container view is layed out the way in can grow in height and adapt to PCVC view height changes.

### Authentication

To utilize SSO authentication, provide a view controller that conforms to `SSOAuthenticatable` protocol:
```swift
extension ArticleViewController: SpotImSDKNavigationDelegate {
    
    func controllerForSSOFlow() -> UIViewController & SSOAuthenticatable {
        let controller: AuthenticationViewController = UIStoryboard(
          name: "Main", 
          bundle: nil
        ).instantiateViewController(withIdentifier: "AuthenticationViewController") as! AuthenticationViewController
        
        return controller
    }
    
}
```

There are to types of SSO available: **Generic SSO** and **Reverse SSO**. Please contact your Spot.IM advisor to pick the best option for you.

#### Generic SSO

1. Get an instance of `SPAuthenticationProvider`
2. Call `startSSO` function and get `codeA` and `jwtToken` from the callback
3. Send the `codeA` and the `jwtToken` to your backend to get `codeB`
4. Call `completeSSO` with the `codeB` and the `jwtToken` from step 2
5. Check `success` and `error` properties in the callback to ensure everything is ok

##### Example
```swift
// 1
var ssoAuthProvider: SPAuthenticationProvider = SPDefaultAuthProvider()

func authenticate() {
    // 2
    ssoAuthProvider.startSSO { [weak self] response, error in
        if let error = error {
            print(error)
        } else {
            self?.getCodeB(codeA: response?.codeA, jwtToken: response?.jwtToken)
        }
    }
}

private func getCodeB(codeA: String?, jwtToken: String?) {
    // 3
    MyAuthenticationProvider.getCodeB(
        with: codeA,
        accessToken: jwtToken,
        username: username,
        accessTokenNetwork: myUserToken) { [weak self] codeB, error in
            if let error = error {
                print(error)
            } else {
                self.completeSSO(genericToken: genericToken)
            }
    }
}

private func completeSSO(codeB: String?, jwtToken: String?) {
    // 4
    ssoAuthProvider.completeSSO(with: codeB, genericToken: genericToken) { [weak self] success, error in
        // 5
        if let error = error {
            print(error)
        } else if success {
            print(“Authenticated successfully!”)
        } 
    }
}
```

#### Reverse SSO

1. Authenticate a user with your backend
2. Get an instance of `SPAuthenticationProvider`
3. Call `startSSO` function with a userToken 
4. If there’s no error in the call back and `response?.success` is true, the authentication process finished successfully

##### Example
```swift
var ssoAuthProvider: SPAuthenticationProvider = SPDefaultAuthProvider()

func authenticate() {
    ssoAuthProvider.startSSO(with: myUserToken, completion: { (response, error) in
        if let error = error {
            print(error)
        } else if let success = response?.success, success {
            print(“Authenticated successfully!”)
        }
    })
}
```

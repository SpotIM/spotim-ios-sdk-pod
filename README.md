# Get Started

### Installation via CocoaPods:
1. Set dependency as follows: `pod 'SpotIMCore'`
2. Execute pod install in Terminal
3. Open workspace file and run

### Setup

First import our SDK from the AppDelegate
`import Spot_IM_Core`

To use the SDK you need to set your unique Spot ID when initializing the SDK. 
In the `application(application:didFinishLaunchingWithOptions)` call the `setup` method as follows: 

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

Authentication with SSO:

#### SSO

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

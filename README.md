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

### Flows

Our SDK exposes one major flow to set up. The pre-conversation view is a view that displays a preview of 2 comments from the conversation, a text box to create new comments and a button to see all comments.

The Pre-conversation view should be displayed in your article view controller beloew the article.

When the user wants to see more comments we push a new ViewController which displays all comments from the conversation.

When clicking on the text box to create a new comments we bring the user to the creation screen. The users needs to be logged in inorder to post new comments, this is where the hosting app needs to integrate it's authentication system.

### Usage

End user is supposed to interact with the Pre-Conversation View Controller (PCVC) first. To get and instance of it, you need an instance of `SpotImSDKFlowCoordinator`:
```swift
spotIMCoordinator = SpotImSDKFlowCoordinator(delegate: self)
```
Make sure to have a strong reference, it will be deallocated otherwise.
Then you can instantiate PCVC for specific post (article) ID. PCVC will be passed to the completion block:
```swift
spotIMCoordinator?.preConversationController(
  withPostId: "POST ID",
  container: navigationController, 
  completion: { [weak self] preConversationVC in 
    // add preConversationVC to your view controller
  }
)
```

PCVC's view should be added as a subview of a view of another view controller.

##### ⚠️ IMPORTANT
Please make sure to use the same post id you use on your web application so that the SDK would be able to display the same comments from the web application.

#### Adding Pre-Conversation VC

1. Add PCVC as a child of another VC
2. Add PCVC view to a view of another VC or a container view
3. Layout the PCVC view
4. Call `open func didMove(toParent parent: UIViewController?)` method of PCVC instance

##### Example

```swift
preConversationVC.view.translatesAutoresizingMaskIntoConstraints = false

self.addChild(preConversationVC)
self.containerView.addSubview(preConversationVC.view)

preConversationVC.view.topAnchor.constraint(equalTo: self.containerView.topAnchor).isActive = true
preConversationVC.view.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor).isActive = true
preConversationVC.view.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor).isActive = true
preConversationVC.view.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor).isActive = true

preConversationVC.didMove(toParent: self)
```
##### ⚠️ IMPORTANT
Make sure container view is layed out the way it can grow in height and adapt to PCVC view height changes.

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

# Troubleshooting

##### Cocoapods installaion fails with error
```
[!] Unable to find a specification for `SpotIMCore...
```
##### Solution
run `pod repo update` in the terminal to refresh your local spec repos before installation.

##### Pod search fails with error
```
[!] Unable to find a pod with name, author, summary, or description matching `SpotIMCore`
```
##### Solution
CocoaPods search index has some known bugs. Just proceed with usual installation.

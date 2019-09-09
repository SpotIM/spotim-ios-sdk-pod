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

To use the SDK you need to set your unique Spot ID key first. Once Spot ID is set, the SDK loads config. You want to proceed working with the SDK once the the config is loaded. To respond to this event, subscribe to `Notification.Name.spotIMConfigLoaded` notification, for example, like this:
```swift
NotificationCenter.default.addObserver(
    self,
    selector: #selector(utilizeConfig),
    name: Notification.Name.spotIMConfigLoaded,
    object: nil
)
```

Once subscribed, set the Spot ID:
```swift
SPClientSettings.setup(spotKey: "YOUR UNIQUE SPOT ID")
```

### Usage
End user is supposed to interact with the Pre-Conversation View Controller (PCVC) first. To get and instance of it, you need an instance of `SpotImSDKFlowCoordinator`:
```swift
spotIMCoordinator = SpotImSDKFlowCoordinator(spotId: spotId, delegate: self)
```
Make sure to have a strong reference, it will be deallocated otherwise.
Then you can instantiate PCVC for specific post (article) ID:
```swift
let preConversationVC = spotIMCoordinator?.preConversationController(
                          with: "POST ID",
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

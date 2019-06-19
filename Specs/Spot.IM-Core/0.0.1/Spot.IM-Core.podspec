#
# Be sure to run `pod lib lint Spot.IM-Core.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Spot.IM-Core'
  s.version          = '0.0.1'
  s.summary          = 'This SDK allows you to integrate SpotIM into your iOS app.'
  s.description      = <<-DESC

## Welcome to the Spot.IM SDK

Spot.IM SDK provides an easy integration with [Spot.IM](http://www.spot.im) into a native iOS app.

## Getting started

To use the SDK you will need an active Spot.IM account. If you don't have it, get one [here](http://www.spot.im).
You will need to know your Spot ID (which looks like 'sp_xxxxxxx').
If you don't know your Spot ID, login to the [admin dashboard](https://admin.spot.im) and have a look at the URL.

DESC

  s.homepage        = "http://www.spot.im"
  s.screenshots     = 'https://user-images.githubusercontent.com/607917/35287547-4076605c-006b-11e8-9674-a1c9e4f8f681.png', 'https://user-images.githubusercontent.com/607917/35287551-423452be-006b-11e8-96e9-7bf7a3ae27b6.png', 'https://user-images.githubusercontent.com/607917/35287552-4259dc5a-006b-11e8-9a27-c14b37a5a32b.png'
  s.license         = { :type => 'CUSTOM', :file => 'LICENSE' }
  s.author          = { 'Andriy Fedin' => 'andriy.fedin@yalantis.com' }
  s.platform        = :ios
  s.ios.deployment_target = '9.0'

# the Pre-Compiled Framework:
  s.source          = { :http => 'https://github.com/SpotIM/spotim-ios-sdk-pod/blob/master/Framework/Spot_IM_Core.framework.zip?raw=true' }
  s.ios.vendored_frameworks = 'Spot_IM_Core.framework'
  s.dependency 'Alamofire', '~> 4.8.2'
  s.dependency 'SnapKit', '~> 4.2.0'

end

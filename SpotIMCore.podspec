#
# Be sure to run `pod lib lint Spot.IM-Core.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SpotIMCore'
  s.version          = '0.0.32'
  s.swift_versions = ['5.0']
  s.summary          = 'Spot.IM SDK'
  s.description      = 'This SDK allows you to integrate SpotIM into your iOS app.'
  s.homepage        = "http://www.spot.im"
  s.screenshots     = 'https://user-images.githubusercontent.com/607917/35287547-4076605c-006b-11e8-9674-a1c9e4f8f681.png', 'https://user-images.githubusercontent.com/607917/35287551-423452be-006b-11e8-96e9-7bf7a3ae27b6.png', 'https://user-images.githubusercontent.com/607917/35287552-4259dc5a-006b-11e8-9a27-c14b37a5a32b.png'
  s.license         = { :type => 'CUSTOM', :file => 'LICENSE' }
  s.author          = { 'Itay Dressler' => 'itay.d@spot.im' }
  s.platform        = :ios
  s.ios.deployment_target = '9.0'

# the Pre-Compiled Framework:
  s.source          = { :http => 'https://github.com/SpotIM/spotim-ios-sdk-pod/blob/master/Framework/SpotImCore.framework.zip?raw=true' }
  s.ios.vendored_frameworks = 'SpotImCore.framework'
  s.dependency 'Alamofire', '~> 4.8.2'
  s.dependency 'PromiseKit', '~> 6.8'
  s.dependency 'Google-Mobile-Ads-SDK', '~> 7.50'

end

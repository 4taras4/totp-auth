# Uncomment the next line to define a global platform for your project
use_frameworks!

def shared_pods
    pod 'Base32'
    pod 'OneTimePassword'
    pod 'RealmSwift'

end

#app
target 'TOTP' do
  platform :ios, '13.0'
  use_frameworks!
  shared_pods
  pod 'Firebase/Core'
  pod 'Firebase/RemoteConfig'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'Swinject', '~> 2.6.2'
  pod 'SwinjectStoryboard', '~> 2.2.0'
  pod 'Google-Mobile-Ads-SDK'

end

#widget
target '2PassExtension' do
  shared_pods
end

#watch
target 'TwoPass Extension' do
  platform :watchos, '4.0'
  shared_pods
end

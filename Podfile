# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
use_frameworks!

def shared_pods
    pod 'RealmSwift'
    pod 'Base32'
    pod 'OneTimePassword'
end

target 'TOTP' do
  shared_pods
  pod 'Firebase/Core'
  pod 'Firebase/RemoteConfig'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Analytics'
  pod 'Swinject', '~> 2.6.2'
  pod 'SwinjectStoryboard', '~> 2.2.0'
  pod 'Google-Mobile-Ads-SDK'

end

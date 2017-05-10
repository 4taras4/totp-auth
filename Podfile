# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

def shared_pods
    pod 'RealmSwift'
    pod 'Base32', '~> 1.1.2'
end

target 'TOTP' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  shared_pods
  pod 'Fabric'
  pod 'Crashlytics'
#  pod 'Zip'
end

target '2Pass'  do
    platform :watchos, '3.0'
    shared_pods
    
end

target '2Pass Extension' do
    platform :watchos, '3.0'
    shared_pods
end

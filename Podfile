platform :ios, '9.0'
use_frameworks!

target 'Goyava' do
    pod 'Fabric'
    pod 'Crashlytics'
    pod 'AWSMobileAnalytics'
    pod 'LookbackSafe', :configurations => ['Release']
    pod 'Realm', git: 'git@github.com:realm/realm-cocoa.git', branch: 'master'
    pod 'RealmSwift', git: 'git@github.com:realm/realm-cocoa.git', branch: 'master'
    pod 'Reachability'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end

platform :ios, "11.0"
use_frameworks!
inhibit_all_warnings!

target 'OfficeChat' do
  pod 'MessageKit', '~>2.0'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'Firebase/Storage'
  pod 'Firebase/Firestore'

  target "OfficeChatTests" do
    inherit! :search_paths  
    pod 'Quick'
    pod 'Nimble'
  end
end

# Disable Code Coverage for Pods projects
post_install do |installer_representation|
    installer_representation.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
        end
    end
end


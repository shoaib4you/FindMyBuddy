# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'FindMyWorkoutBuddy' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FindMyWorkoutBuddy


pod 'IQKeyboardManagerSwift'
pod 'Alamofire', '~> 4.9.1'
pod 'SDWebImage/WebP'
pod 'DropDown'
pod 'Cosmos'
pod 'R.swift', '~> 5.4.0'
#pod 'R.swift'
pod 'SkeletonView'
pod 'SlideMenuControllerSwift'
pod 'CountryPickerView'
pod 'SwiftyJSON'

pod 'Firebase/Core'
pod 'Firebase/Messaging'
pod 'Firebase/Storage'

pod 'Gallery'
pod 'InputMask'
pod 'Stripe'
#pod 'GoogleSignIn'
pod 'GoogleSignIn', '~> 5.0.2'



  target 'FindMyWorkoutBuddyTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'FindMyWorkoutBuddyUITests' do
    # Pods for testing
  end
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
          config.build_settings["ONLY_ACTIVE_ARCH"] = "NO"
        end
      end
    end

end

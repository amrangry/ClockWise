#
# Be sure to run `pod lib lint ClockWise.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ClockWise'
  s.version          = '1.2.6'
  s.summary          = 'ClockWise is a lightweight Swift utilities'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
ClockWise is a lightweight Swift utilities that use the power of extension to add more functionality to UIKit and foundation API.
                       DESC

  s.homepage         = 'https://github.com/amrangry/ClockWise'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  # s.screenshots  = 'https://raw.githubusercontent.com/antonyraphel/ARCarMovement/30b4fa26fc4f14abaef5da147544db8d558b1c18/screenshot/image-1.png'

  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'amrangry' => 'amr.elghadban@gmail.com' }
  s.source           = { :git => 'https://github.com/amrangry/ClockWise.git', :tag => s.version.to_s }
  #s.documentation_url = 'https://clockwise.github.io'
  s.social_media_url = 'https://twitter.com/amr_elghadban'

  s.ios.deployment_target = '12.0'

  #s.source_files = 'ScreenCaptureDetector/Classes/**/*'
  #s.source_files = 'Source/**/*.swift'
  s.source_files = 'Source/**/*'
  s.swift_version = '5.0'
  s.platforms = {
      "ios": "12.0"
  }
   #s.platform = :ios, '11.0'
   #s.requires_arc = true

  # s.resource_bundles = {
  #   'ClockWise' => ['ClockWise/Assets/*.png']
  # }
  #Ref : https://github.com/hyperoslo/BarcodeScanner.git
#   s.resource_bundles = {
#     'BarcodeScanner' => ['Images/*.{png}'],
#     'Localization' => ['Localization/*.lproj/Localizable.strings']
#   }
  
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit'
  s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'Kingfisher', '~> 5.3.1'
  
end

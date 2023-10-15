#
# Be sure to run `pod lib lint ClockWise.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ClockWise'
  s.version          = '1.4.1'
  s.summary          = 'ClockWise is a lightweight Swift utilities'
  s.description      = <<-DESC
ClockWise is a lightweight Swift utilities that use the power of extension to add more functionality to UIKit and foundation API.
                       DESC
  s.homepage         = 'https://github.com/amrangry/ClockWise'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.screenshots      = 'https://raw.githubusercontent.com/amrangry/ClockWise/master/logo.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'amrangry' => 'amr.elghadban@gmail.com' }
  s.source           = { :git => 'https://github.com/amrangry/ClockWise.git', :tag => s.version.to_s }
  #s.documentation_url = 'https://clockwise.github.io'
  s.social_media_url = 'https://twitter.com/amr_elghadban'
  s.ios.deployment_target = '12.0'
  s.source_files = 'Source/**/*'
  s.swift_version = '5.0'
  s.platforms = {
      "ios": "12.0"
  }
   #s.requires_arc = true
  s.frameworks = 'UIKit', 'Foundation'
  
end

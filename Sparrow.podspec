#
# Be sure to run `pod lib lint Sparrow.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'Sparrow'
s.version          = '4.2'
s.summary          = 'A short description of Sparrow.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
TODO: Add long description of the pod here.
DESC

s.homepage         = 'https://github.com/Joeytat/Sparrow'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Joeytat' => 'joeyqaq@gmail.com' }
s.source           = { :git => 'https://github.com/Joeytat/Sparrow.git', :tag => s.version.to_s }

s.ios.deployment_target = '10.0'

s.source_files = 'Sparrow/Classes/**/*'

# s.resource_bundles = {
#   'Sparrow' => ['Sparrow/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'

s.frameworks = 'UIKit'
s.dependency 'Moya', '~> 12.0.1'
s.dependency 'RxSwift', '~> 4.4.0'
s.dependency 'RxCocoa', '~> 4.4.0'
s.dependency 'SnapKit', '~> 4.2.0'
s.dependency 'IQKeyboardManagerSwift', '~> 6.2.0'
s.dependency 'KeychainAccess', '~> 3.1.0'
s.dependency 'KMNavigationBarTransition', '~> 1.1.5'
s.dependency 'Kingfisher', '~> 5.3.1'
s.dependency 'RxDataSources', '~> 3.1.0'
s.dependency 'NSObject+Rx', '~> 4.4.1'
s.dependency 'Reachability', '~> 3.2'
s.dependency 'MJRefresh', '~> 3.1.15.1'
s.dependency 'DKImagePickerController', '~> 4.1.0'
s.dependency 'Toast-Swift', '~> 4.0.1'
end



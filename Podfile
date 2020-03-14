# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'
use_frameworks!

def rxswift
	pod 'RxSwift', '~> 5'
end

def rxcocoa
	pod 'RxCocoa', '~> 5'
end

def rxdatasources
  pod 'RxDataSources'
end

target 'ProductDiscovery' do
  rxswift
  rxcocoa
  rxdatasources
  pod 'Kingfisher', '~> 5.0'
  pod 'MBProgressHUD', '~> 1.1.0'
  pod 'IQKeyboardManagerSwift'
  pod 'Swinject'
  pod 'CRRefresh'
end

target 'Domain' do
  rxswift
  rxcocoa
  rxdatasources
end

target 'NetworkModule' do
  pod 'Alamofire', '~> 5.0.0-rc.3'
  rxswift
end

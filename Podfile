platform :ios, '16.0'

target 'WoWDatabase' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

	pod 'Alamofire'
	pod 'SwiftGen'
	pod 'SFSafeSymbols'
end

post_install do |pi|
	pi.pods_project.targets.each do |t|
		t.build_configurations.each do |config|
			if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_i < 12 then
				config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
			end
		end
	end
end

Pod::Spec.new do |s|
  s.name         = "MySocket"
  s.version      = "0.0.1"
  s.summary      = "A lightweight and pure Swift implemented library for downloading and cacheing image from the web."
  s.homepage     = "https://github.com/616115891/MySocket.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "yejinyong" => "616115891@qq.com" }
  s.source       = { :git => "https://github.com/616115891/MySocket.git", :tag => "#{s.version}" }
  s.source_files  = "MySocket", "MySocket/**/*.{h,m}"
  #s.exclude_files = "Classes/Exclude"
  s.ios.frameworks = "CFNetwork"
  s.ios.deployment_target = "10.3"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
end

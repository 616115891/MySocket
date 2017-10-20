Pod::Spec.new do |s|
  s.name         = "MySocket"
  s.version      = "0.0.3"
  s.summary      = "Keyon Socket."
  s.description  = <<-DESC
                   Keyon
                   DESC
  s.homepage     = "https://github.com/616115891/MySocket.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "yejinyong" => "616115891@qq.com" }
  s.source       = { :git => "https://github.com/616115891/MySocket.git", :tag => "#{s.version}" }
  s.source_files  = "MySocket", "MySocket/**/*.{h,m}"
  #s.exclude_files = "Classes/Exclude"
  s.ios.frameworks = "CFNetwork","UIKit"
  s.ios.deployment_target = "10.3"
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
end

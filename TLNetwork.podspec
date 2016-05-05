
Pod::Spec.new do |s|
  s.name         = "TLNetwork"
  s.version      = "0.0.3"
  s.summary      = "基于AFNetwork 3.x封装的简单GET、POST网络请求。"
  s.description  = "1、基于AFNetwork 3.x封装的简单GET、POST网络请求。2、多文件上传。"
  s.homepage     = "https://github.com/TedLiuHome/TLNetwork"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "ihomelp07" => "ihomelp07@gmail.com" }
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/TedLiuHome/TLNetwork.git", :tag => s.version.to_s ,:commit => "70945b6f7dfad4fabe048a4911be4afff3761ca9"}
  s.source_files = "NetwrokHandle/**/*.{h,m}","DSTost/*.{h,m}"
  s.resource     = "NetwrokHandle/**/*.png"
  s.requires_arc = true
  s.dependency "AFNetworking", "~> 3.1.0"
  s.dependency "SVProgressHUD"
  s.dependency "JSONModel"

end

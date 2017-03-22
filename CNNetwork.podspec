Pod::Spec.new do |s|
  s.name         = "CNNetwork"
  s.version      = "0.0.4"
  s.summary      = "CNNetwork."
  s.homepage     = "https://github.com/AmineChan/CNNetwork"
  s.license      = "MIT"
  s.author       = {"czm" => "328525910@qq.com",}

  s.source       = { :git  => "https://github.com/AmineChan/CNNetwork.git", :tag => s.version }
  s.source_files  = ['CNNetwork/*.{h,m}', 'CNNetwork/**/*.{h,m}']

  s.platform      = :ios, '7.0'
  s.requires_arc  = true
  s.dependency "AFNetworking"
  s.libraries = "resolv"
end

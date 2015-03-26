Pod::Spec.new do |s|
  s.name             = "ImageFormatInspector"
  s.version          = "0.1.0"
  s.summary          = "Inspect NSData to figure out its image format."
  s.homepage         = "https://github.com/sweetmandm/ImageFormatInspector"
  s.license          = 'MIT'
  s.author           = { "David Sweetman" => "david@davidsweetman.com" }
  s.source           = { :git => "https://github.com/sweetmandm/ImageFormatInspector.git", :tag => s.version.to_s }
 
  s.platform     = :ios, '6.0'
  s.requires_arc = false
  s.source_files = 'ImageFormatInspector.{h,m}'
  s.public_header_files = 'ImageFormatInspector.h'
end

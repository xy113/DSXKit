Pod::Spec.new do |s|
  s.name     = 'DSXKit'
  s.version  = '1.0.0'
  s.license  = 'MIT'
  s.summary  = 'DSXKit framework.'
  s.homepage = 'https://github.com/xy113/DSXKit'
  s.authors  = { 'xy113' => 'songdewei@163.com' }
  s.source   = { :git => 'https://github.com/xy113/DSXKit.git', :tag => s.version, :submodules => true }
  s.requires_arc = true
  s.platform     = :ios, "8.0" 
  
  s.public_header_files = 'DSXKit/**/*.{h}'
  s.source_files = 'DSXKit/**/*.{h,m}'
  s.resource = 'DSXKit/DSXKit.bundle'
  
  s.libraries = 'z', 'sqlite3', 'c++'
  s.frameworks = 'UIKit', 'CoreFoundation', 'CoreText', 'CoreGraphics', 'CoreImage', 'QuartzCore', 'ImageIO', 'AssetsLibrary', 'Accelerate', 'MobileCoreServices', 'SystemConfiguration','CoreMotion'
  
  s.dependency "WebViewJavascriptBridge"
end
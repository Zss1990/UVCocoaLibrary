Pod::Spec.new do |spec|
  spec.name         = 'UVCocoaLibrary'
  spec.version      = '1.0.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/selecterskycocoa/UVCocoaLibrary'
  spec.authors      = { 'selectersky' => 'selectersky@qq.com' }
  spec.summary      = 'a common library for cocoa'
  spec.source       = { :git => 'https://github.com/selecterskycocoa/UVCocoaLibrary'}
  spec.requires_arc = true
  spec.source_files = 'Category/**/*.{h,m}', 'Database/**/*.{h,m}', 'Helper/**/*.{h,m}', 'Include/**/*.{h,m}', 'Media/**/*.{h,m}', 'Model/**/*.{h,m}', 'Request/**/*.{h,m}', 'Widget/**/*.{h,m}'
  
  spec.public_header_files = 'Category/*.h','Database/*.h','Helper/*.h','Include/*.h','Media/*.h','Model/*.h','Request/*.h','Widget/*.h'

  spec.resource = 'UVCocoaLibrary/Assets.xcassets'

  spec.dependency 'FMDB'
  spec.dependency 'MBProgressHUD'
end
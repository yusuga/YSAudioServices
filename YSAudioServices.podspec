Pod::Spec.new do |s|
  s.name = 'YSAudioServices'
  s.version = '0.0.4'
  s.summary = 'AudioServices helper.'
  s.homepage = 'https://github.com/yusuga/YSAudioServices'
  s.license = 'MIT'
  s.author = 'Yu Sugawara'
  s.source = { :git => 'https://github.com/yusuga/YSAudioServices.git', :tag => s.version.to_s }
    s.platform = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.requires_arc = true
  s.source_files = 'Classes/YSAudioServices/*.{h,m}'
end
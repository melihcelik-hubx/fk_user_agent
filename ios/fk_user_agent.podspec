#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint fk_user_agent.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'fk_user_agent'
  s.version          = '3.0.0'
  s.summary          = 'Flutter plugin for retrieving device user agents.'
  s.description      = <<-DESC
Retrieve Android and iOS device user agents, including WebView user agents, from Flutter.
                       DESC
  s.homepage         = 'https://github.com/flutter-fast-kit/fk_user_agent'
  s.license          = { :type => 'MIT', :file => '../LICENSE' }
  s.author           = { 'lunnnnul' => 'lunnnnul@gmail.com' }
  s.source           = { :git => 'https://github.com/flutter-fast-kit/fk_user_agent.git', :tag => s.version.to_s }
  s.source_files = 'fk_user_agent/Sources/fk_user_agent/**/*.{h,m}'
  s.public_header_files = 'fk_user_agent/Sources/fk_user_agent/include/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end

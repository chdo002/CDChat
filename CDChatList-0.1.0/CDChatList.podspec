Pod::Spec.new do |s|
  s.name = "CDChatList"
  s.version = "0.1.0"
  s.summary = "\u{804a}\u{5929}\u{754c}\u{9762}\u{7684}\u{5c01}\u{88c5}."
  s.license = {"type"=>"MIT", "file"=>"LICENSE"}
  s.authors = {"chdo002"=>"1107661983@qq.com"}
  s.homepage = "http://git-ma.paic.com.cn/aat_component_ios/ChatList"
  s.description = "ios \u{7248}\u{672c}\u{5bf9}\u{804a}\u{5929}\u{754c}\u{9762}\u{7684}\u{5c01}\u{88c5}"
  s.frameworks = "UIKit"
  s.source = { :path => '.' }

  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = 'ios/CDChatList.framework'
end

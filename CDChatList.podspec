#
# Be sure to run `pod lib lint CDChatList.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CDChatList'
  s.version          = '0.1.0'
  s.summary          = '聊天界面的封装.'

  s.description      = <<-DESC
    ios 版本对聊天界面的封装
                       DESC

  s.homepage         = 'http://git-ma.paic.com.cn/aat_component_ios/ChatList'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chdo002' => '1107661983@qq.com' }
  s.source           = { :git => 'https://github.com/chdo002/CDChatList.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CDChatList/Classes/**/*'
  
  s.resource_bundles = {
     'CDChatList' => ['CDChatList/Assets/*.png']
  }

  s.public_header_files = 'CDChatList/Classes/**/**/*.h'
  s.frameworks = 'UIKit'

  s.dependency 'SDWebImage'
  s.dependency 'YYText'

# s.dependency 'Masonry'
# s.dependency 'TTTAttributedLabel'
# s.dependency 'MBProgressHUD'

end

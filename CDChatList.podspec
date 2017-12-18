

Pod::Spec.new do |s|
    s.name             = 'CDChatList'
    s.version          = '0.2.2'
    s.summary          = '聊天界面的封装.'

    s.description      = <<-DESC
        ios 版本对聊天界面的封装
                       DESC
    s.homepage         = 'http://git-ma.paic.com.cn/aat_component_ios/ChatList'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'chdo002' => '1107661983@qq.com' }
    s.source           = { :git => 'http://git-ma.paic.com.cn/aat/ChatList.git', :tag => s.version.to_s }

    s.ios.deployment_target = '8.0'

    s.subspec 'CDLabel' do |label|
        label.source_files = 'CDChatList/Classes/CDLabel/**/*'
        label.public_header_files = 'CDChatList/Classes/CDLabel/**/*.h'
    end

    s.subspec 'CDChatInputBox' do |inputbox|
        inputbox.source_files = 'CDChatList/Classes/CDChatInputBox/**/*'
        inputbox.public_header_files = 'CDChatList/Classes/CDChatInputBox/**/*.h'
        inputbox.dependency 'CDChatList/CDLabel'
    end

    s.source_files = 'CDChatList/Classes/**/*'
    s.public_header_files = 'CDChatList/Classes/**/**/*.h'

# s.vendored_libraries  = 'CDChatList/Classes/libs/libUtility/*.{a}'

    s.frameworks = 'UIKit'
    s.dependency 'SDWebImage'
    s.dependency 'Utility'
end

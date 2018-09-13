
Pod::Spec.new do |s|
  s.name             = 'CDChatList'
  s.version          = '0.2.2'
  s.summary          = 'Awesome chatlist component for iOS.'
  s.homepage         = 'https://github.com/chdo002/CDChatList'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'chdo002' => '1107661983@qq.com' }
  s.source           = { :git => 'https://github.com/chdo002/CDChatList.git', :tag => s.version.to_s }

  s.ios.deployment_target = '7.0'

  s.source_files = 'CDChatList/Classes/**/**/*.{h,m}'
  s.public_header_files = 'CDChatList/Classes/**/**/*.h'
  
  
  # CDLabel目前分离出去 https://github.com/chdo002/CDLabel
  #s.subspec 'CDLabel' do |label|
  #  label.source_files = 'CDChatList/Classes/CDLabel/**/*.{h,m}'
  #end
  
  s.resource_bundles = {
      'CDInputViewBundle' => ['CDChatList/Assets/CDInputViewBundle/*'],
      'CDExpression' => ['CDChatList/Assets/CDExpression/*']
  }

  s.subspec 'CDChatInputBox' do |input|
    input.source_files = 'CDChatList/Classes/CDChatInputBox/**/*.{h,m}'
  end
  
  
  
  s.dependency 'SDWebImage'
  s.dependency 'CDLabel', '0.1.0'
end

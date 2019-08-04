Pod::Spec.new do |s|
s.name         = 'CDDGroupAvatar'
s.version      = '1.1.0'
s.summary      = 'iOS 群头像 / Easy to use'

s.description  = <<-DESC
iOS 群头像功能，像加载一张图片那么简单。
DESC

s.homepage     = 'https://github.com/RocketsChen/CDDGroupAvatar'
s.license      = 'MIT'  #开源协议
s.authors      = {'RcoketsChen' => '1062749739@qq.com'}
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/RocketsChen/CDDGroupAvatar.git', :tag => '1.1.0'}
s.source_files = "CDDGroupAvatar", "CDDGroupAvatar/*.{h,m}"
s.requires_arc = true

s.frameworks   = "Foundation", "UIKit"
s.dependency 'SDWebImage', '~>5.0.0'

end

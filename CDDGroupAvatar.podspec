Pod::Spec.new do |s|
s.name         = 'CDDGroupAvatar'
s.version      = '1.5.3'
s.summary      = 'iOS 群头像 / Easy to use'

s.description  = <<-DESC
iOS 群头像功能，像加载一张图片那么简单。
DESC

s.homepage     = 'https://github.com/RocketsChen/CDDGroupAvatar'
s.license      = 'MIT'  #开源协议
s.authors      = {'RcoketsChen' => '1062749739@qq.com'}
s.platform     = :ios, '9.0'
s.source       = {:git => 'https://github.com/RocketsChen/CDDGroupAvatar.git', :tag => '1.5.3'}
s.requires_arc     = true
s.frameworks       = 'UIKit'
s.default_subspec  = 'Cache'

    s.subspec 'NoCache' do |ss|
    
      ss.source_files = 'CDDGroupAvatar' , 'CDDGroupAvatar/DCAvatar/*' , 'CDDGroupAvatar/CDDNoCacheGroupAvatar/*'
      
    end
    
    
    s.subspec 'Cache' do |ss|
    
      ss.source_files = 'CDDGroupAvatar' , 'CDDGroupAvatar/DCAvatar/*' , 'CDDGroupAvatar/CDDCacheGroupAvatar/*'
      s.dependency 'SDWebImage'
      
    end
    
    
    s.subspec 'Core' do |ss|
    
      ss.source_files = 'CDDGroupAvatar' , 'CDDGroupAvatar/DCAvatar/*' , 'CDDGroupAvatar/CDDNoCacheGroupAvatar/*' , 'CDDGroupAvatar/CDDCacheGroupAvatar/*'
      s.dependency 'SDWebImage'
      
    end
    
end

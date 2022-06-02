#
# Be sure to run `pod lib lint KYPerformanceMonitor.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KYPerformanceMonitor'
  s.version          = '0.1.0'
  s.summary          = 'iOS 性能监测'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                        包含帧率检测 和 主线程耗时任务检测
                        添加耗时任务检测策略，根据枚举值控制
                       DESC

  s.homepage         = 'https://gitee.com/kangpp/kyperformance-monitor'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT'}
  s.author           = { 'kangpengpeng' => '353327533@qq.com' }
  s.source           = { :git => 'https://gitee.com/kangpp/kyperformance-monitor.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'KYPerformanceMonitor/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KYPerformanceMonitor' => ['KYPerformanceMonitor/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

#
# Be sure to run `pod lib lint SDWebImageFLPlugin.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SDWebImageFLPlugin'
  s.version          = '1.0.0'
  s.summary          = 'A FLAnimatedImage plugin for SDWebImage'

  s.description      = <<-DESC
This project adds a plugin for FLAnimatedImage into SDWebImage, for loading animated images. FLAnimatedImage is a performant library that handles animated images rendering, while SDWebImage takes care of downloading, caching and loading the images.
                       DESC

  s.homepage         = 'https://github.com/SDWebImage/SDWebImageFLPlugin'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'DreamPiggy' => 'lizhuoli1126@126.com' }
  s.source           = { :git => 'https://github.com/SDWebImage/SDWebImageFLPlugin.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'SDWebImageFLPlugin/Classes/**/*', 'SDWebImageFLPlugin/Module/SDWebImageFLPlugin.h'
  s.module_map = 'SDWebImageFLPlugin/Module/SDWebImageFLPlugin.modulemap'

  s.dependency 'SDWebImage/Core'
  s.dependency 'FLAnimatedImage', '~> 1.0'
end

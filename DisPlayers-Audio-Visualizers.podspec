#
# Be sure to run `pod lib lint DisPlayers-Audio-Visualizers.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DisPlayers-Audio-Visualizers'
  s.version          = '0.1.0'
  s.platform         = :ios, '8.0'
  s.summary          = 'A short description of DisPlayers-Audio-Visualizers.'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/agilie/DisPlayers-Audio-Visualizers'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Agilie' => 'info@agilie.com' }
  s.source           = { :git => 'https://github.com/agilie/DisPlayers-Audio-Visualizers.git', :tag => '0.1.0' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'DisPlayers-Audio-Visualizers/Classes/**/*'
  
  # s.resource_bundles = {
  #   'DisPlayers-Audio-Visualizers' => ['DisPlayers-Audio-Visualizers/Assets/*.png']
  # }

    s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit', 'MapKit', 'AVFoundation', 'Accelerate'
    s.dependency 'EZAudio', '~> 1.1.4'

end

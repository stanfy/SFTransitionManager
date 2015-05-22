Pod::Spec.new do |s|

  s.name         = 'SFTransitionManager'
  s.version      = '0.0.1'
  s.summary      = 'Custom animation transition manager.'

  s.homepage     = 'http://dev.stanfy.com'
  s.license      = { :type => 'MIT' }

  s.author       = { 'Vitalii Bogdan' => 'vbogdan@stanfy.com.ua', 'Paul Taykalo' => 'ptaykalo@stanfy.com.ua' }

  s.source       = { :git => 'https://github.com/stanfy/SFTransitionManager.git', :tag => '0.0.1' }

  s.platform     = :ios, '7.0'

  s.source_files = 'Classes/**/*.{h,m}'
  s.requires_arc = true

end
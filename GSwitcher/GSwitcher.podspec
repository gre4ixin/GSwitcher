
Pod::Spec.new do |s|
  s.name                  = "GSwitcher"
  s.version               = "0.0.1"
  s.summary               = "Simple custom switch"
  s.homepage              = "https://github.com/gre4ixin/GSwitcher"
  s.license               = { :type => 'MIT', :file => 'https://github.com/gre4ixin/GSwitcher/blob/master/LICENSE' }
  s.author                = { "Pavel Gre4ixin" => "pav.gre4ixin@yandex.ru" }
  s.platform              = :ios, '11.0'
  s.source                = { :git => "https://github.com/gre4ixin/GSwitcher.git", :tag => s.version.to_s }
  s.source_files          = 'GSwitcher/GSwitcher/GSwitcher/Classes/*'
  s.public_header_files   = 'GSwitcher/GSwitcher/GSwitcher/Classes/*.h'
  s.framework             = 'UIKit'
  s.requires_arc          = true
end
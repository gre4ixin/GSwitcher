
Pod::Spec.new do |s|
  s.name                  = "GSwitcher"
  s.version               = "0.0.2"
  s.summary               = "Simple custom switch"
  s.homepage              = "https://github.com/gre4ixin/GSwitcher"
  s.license               = { :type => 'MIT', :file => 'LICENSE' }
  s.author                = { "Pavel Gre4ixin" => "pav.gre4ixin@yandex.ru" }
  s.ios.deployment_target = "11.0"
  s.source                = { :git => "https://github.com/gre4ixin/GSwitcher.git", :tag => s.version.to_s }
  s.source_files          = "Sources/*.swift"
  s.frameworks             = "UIKit"
end
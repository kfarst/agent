Pod::Spec.new do |s|
  s.name                  = "Agent-PromiseKit"
  s.summary               = "Minimalistic Swift HTTP request agent for iOS and OS X built on PromiseKit"
  s.version               = "0.1.0"
  s.homepage              = "https://github.com/kfarst/agent+promisekit"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { "kfarst" => "farst.6@gmail.com" }
  s.source                = { :git => "https://github.com/kfarst/agent+promisekit.git", :tag => "#{s.version}" }
  s.source_files          = "Agent+PromiseKit/Agent+PromiseKit.swift"
  s.dependency "PromiseKit/Foundation", "~3.0"
  s.requires_arc          = true
  s.ios.deployment_target = "9.0"
  s.osx.deployment_target = "10.11"
end

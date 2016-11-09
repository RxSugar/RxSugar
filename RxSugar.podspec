Pod::Spec.new do |s|
  s.name             = "RxSugar"
  s.version          = "0.1.1"
  s.summary          = "Simple RxSwift extensions for interacting with Apple APIs"
  s.description      = <<-DESC
    RxSugar adds simple UI extensions for interacting with Apple APIs, and includes custom operators.
    
    For more information, see [the README](https://github.com/RxSugar/RxSugar).
                        DESC
  s.homepage         = "https://github.com/RxSugar/RxSugar"
  s.license          = 'MIT'
  s.author           = { "James Rantanen" => "jarinteractive@gmail.com",
                     "Mark Sands" => "marksands07@gmail.com",
                     "Asynchrony" => nil }
  s.source           = { :git => "https://github.com/RxSugar/RxSugar.git", :tag => "v0.1.1" }
  s.requires_arc          = true

  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"
  
  s.source_files  = "RxSugar/RxSugar.h", "RxSugar/**/*.{swift}"
  s.exclude_files = "RxSugarTests"
  s.tvos.exclude_files = "RxSugar/UISwitch+Sugar.swift"

  s.dependency "RxSwift", "~> 3.0"
end

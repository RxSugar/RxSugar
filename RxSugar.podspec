Pod::Spec.new do |s|
  s.name         = "RxSugar"
  s.version      = "0.0.10"
  s.summary      = "Simple RxSwift extensions for interacting with Apple APIs"
  s.description  = <<-DESC
    RxSugar adds simple UI extensions for interacting with Apple APIs, and includes custom operators.
    
    For more information, see [the README](https://github.com/RxSugar/RxSugar).
    DESC
  s.homepage     = "https://github.com/RxSugar/RxSugar"
  s.license      = "MIT"
  s.author       = { "James Rantanen" => "jarinteractive@gmail.com",
                     "Mark Sands" => "marksands07@gmail.com",
                     "Asynchrony" => nil }
                     
  s.ios.deployment_target = "8.0"
  s.tvos.deployment_target = "9.0"
  
  s.source       = { :git => "https://github.com/RxSugar/RxSugar.git", :tag => "v0.0.10" }
  s.ios.source_files  = "RxSugar/RxSugar.h", "RxSugar/**/*.{swift}"
  s.ios.exclude_files = "RxSugarTests"  
  s.tvos.source_files = "RxSugar/RxSugar.h", "RxSugar/**/*.{swift}"
  s.tvos.exclude_files = "RxSugarTests", "RxSugar/UISwitch+Sugar.swift"

  s.requires_arc = true
  
  s.dependency "RxSwift", "~> 2.3"
end

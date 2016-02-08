Pod::Spec.new do |s|
  s.name         = "RxSugar"
  s.version      = "0.0.1"
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
                     
  s.platform     = :ios, "8.0"
  
  s.source       = { :git => "https://github.com/RxSugar/RxSugar.git", :tag => "v0.0.1" }
  s.source_files  = "RxSugar/RxSugar.h", "RxSugar/**/*.{swift}"
  s.exclude_files = "RxSugarTests"  
  s.requires_arc = true
  
  s.dependency "RxSwift", "~> 2.0"
end

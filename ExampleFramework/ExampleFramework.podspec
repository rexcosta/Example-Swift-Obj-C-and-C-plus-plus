
Pod::Spec.new do |s|

  s.name         = "ExampleFramework"
  s.version      = "0.0.1"
  s.summary      = "Pod with Obj-C and C++"
  s.description  = "ExampleFramework"
  s.homepage     = "https://github.com/rexcosta"
  s.author       = { "david" => "https://github.com/rexcosta" }
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/rexcosta/Example_Swift_ObjC_C-" }

  s.source_files  =
    "ExampleFramework/api/**/*.{h,m,mm}",
    "ExampleFramework/core/**/*.{h,hpp,c,cpp,m,mm}"

# expose only the files that the Framework user needs
  s.public_header_files =
    "ExampleFramework/api/**/*.{h}"

end

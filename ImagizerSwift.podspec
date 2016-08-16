Pod::Spec.new do |spec|
  spec.name = "ImagizerSwift"
  spec.version = "1.0.0"
  spec.summary = "A swift SDK for the ImagizerEngine"
  spec.homepage = "https://github.com/nventify/ImagizerSwift"
  spec.license = { type: 'MIT', file: 'LICENSE' }
  spec.authors = { "Nicholas Pettas" => 'nick@nventify.com' }

  spec.platform = :ios, "9.1"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/nventify/ImagizerSwift.git", tag: "v#{spec.version}", submodules: true }
  spec.source_files = 'ImagizerSwift/*.{h,m}'
end

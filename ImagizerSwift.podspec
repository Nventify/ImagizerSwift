Pod::Spec.new do |spec|
  spec.name = "ImagizerSwift"
  spec.version = "0.2.0"
  spec.summary = "The official swift client for the ImagizerEngine."
  spec.homepage = "https://github.com/nventify/ImagizerSwift"
  spec.license = { type: 'APACHE', file: 'LICENSE' }
  spec.authors = { "Nicholas Pettas" => 'nick@nventify.com' }

  spec.platforms = { :ios => "9.2", :osx => "10.10", :tvos => "9.2" }

  spec.requires_arc = true
  spec.source = { git: "https://github.com/nventify/ImagizerSwift.git", tag: "v#{spec.version}", submodules: true }

  spec.requires_arc = true
  spec.source_files = 'ImagizerSwift/*.{h,m,swift}'
end

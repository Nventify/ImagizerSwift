Pod::Spec.new do |spec|
  spec.name = "ImagizerSwift"
  spec.version = "0.1.1"
  spec.summary = "The official swift client for the ImagizerEngine."
  spec.homepage = "https://github.com/nventify/ImagizerSwift"
  spec.license = { type: 'APACHE', file: 'LICENSE' }
  spec.authors = { "Nicholas Pettas" => 'nick@nventify.com' }

  spec.platform = :ios, "9.1"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/nventify/ImagizerSwift.git", tag: "v#{spec.version}", submodules: true }

  spec.requires_arc = true
  spec.source_files = 'ImagizerSwift/*.{h,m,swift}'
end

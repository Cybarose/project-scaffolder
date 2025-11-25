# frozen_string_literal: true

require_relative "lib/proj/version"

Gem::Specification.new do |spec|
  spec.name          = "proj"
  spec.version       = Proj::VERSION
  spec.authors       = ["Sarah"] # Optional: dein voller Name
  spec.email         = ["you@example.com"] # Optional

  spec.summary       = "Project initializer CLI for consistent project scaffolding."
  spec.description   = "proj is a small CLI tool that initializes new projects from predefined templates, providing a consistent structure and reducing repetitive setup work."
  spec.license       = "MIT"

  spec.files         = Dir.glob("bin/*") + Dir.glob("lib/**/*") + %w[README.md LICENSE]
  spec.executables   = ["proj"]
  spec.require_paths = ["lib"]

  spec.metadata = {
    "homepage_uri"    => "https://gitlab.com/your-namespace/proj",
    "source_code_uri" => "https://gitlab.com/your-namespace/proj"
  }
end

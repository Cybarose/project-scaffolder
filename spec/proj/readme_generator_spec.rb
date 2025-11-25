# frozen_string_literal: true

require "spec_helper"

RSpec.describe Proj::ReadmeGenerator do
  it "creates a README.md with the project name and default sections" do
    Dir.mktmpdir do |dir|
      generator = described_class.new(
        project_name: "MyProject",
        target_dir: dir,
        description: nil,
        force: false
      )

      generator.run

      readme_path = File.join(dir, "README.md")
      expect(File.exist?(readme_path)).to be true

      content = File.read(readme_path)
      expect(content).to include("# MyProject")
      expect(content).to include("## Overview")
      expect(content).to include("## Installation")
      expect(content).to include("## Usage")
    end
  end

  it "uses the provided description when given" do
    Dir.mktmpdir do |dir|
      description = "Short description for the project."

      generator = described_class.new(
        project_name: "MyProject",
        target_dir: dir,
        description: description,
        force: false
      )

      generator.run

      readme_path = File.join(dir, "README.md")
      content = File.read(readme_path)
      expect(content).to include(description)
    end
  end

  it "does not overwrite an existing README.md without force" do
    Dir.mktmpdir do |dir|
      readme_path = File.join(dir, "README.md")
      File.write(readme_path, "original content")

      generator = described_class.new(
        project_name: "MyProject",
        target_dir: dir,
        description: "New description",
        force: false
      )

      expect { generator.run }
        .to raise_error(Proj::ReadmeGenerator::ReadmeExistsError)

      content = File.read(readme_path)
      expect(content).to eq("original content")
    end
  end

  it "overwrites an existing README.md when force is true" do
    Dir.mktmpdir do |dir|
      readme_path = File.join(dir, "README.md")
      File.write(readme_path, "original content")

      generator = described_class.new(
        project_name: "MyProject",
        target_dir: dir,
        description: "New description",
        force: true
      )

      expect { generator.run }.not_to raise_error

      content = File.read(readme_path)
      expect(content).to include("New description")
      expect(content).not_to eq("original content")
    end
  end
end

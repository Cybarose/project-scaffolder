# frozen_string_literal: true

require "spec_helper"

RSpec.describe Proj::ProjectGenerator do
  let(:template) do
    Proj::Template.new(
      name: "test-template",
      description: "Test template",
      directories: %w[src docs],
      files: {
        "README.md" => "# Test Project\n",
        "src/main.rb" => "puts 'hello'\n"
      }
    )
  end

  it "creates the target directory, subdirectories, and files" do
    Dir.mktmpdir do |dir|
      project_name = File.join(dir, "my_project")

      generator = described_class.new(
        template: template,
        project_name: project_name,
        git: false,
        force: false
      )

      generator.run

      expect(Dir.exist?(project_name)).to be true
      expect(Dir.exist?(File.join(project_name, "src"))).to be true
      expect(Dir.exist?(File.join(project_name, "docs"))).to be true

      expect(File.exist?(File.join(project_name, "README.md"))).to be true
      expect(File.exist?(File.join(project_name, "src/main.rb"))).to be true
    end
  end

  it "initializes a git repository when git is true" do
    Dir.mktmpdir do |dir|
      project_name = File.join(dir, "git_project")

      generator = described_class.new(
        template: template,
        project_name: project_name,
        git: true,
        force: false
      )

      generator.run

      git_dir = File.join(project_name, ".git")
      expect(Dir.exist?(git_dir)).to be true
    end
  end

  it "raises an error when the target directory exists and force is false" do
    Dir.mktmpdir do |dir|
      project_name = File.join(dir, "existing_project")
      FileUtils.mkdir_p(project_name)

      generator = described_class.new(
        template: template,
        project_name: project_name,
        git: false,
        force: false
      )

      expect { generator.run }
        .to raise_error(Proj::ProjectGenerator::DirectoryExistsError)
    end
  end

  it "reuses an existing directory when force is true" do
    Dir.mktmpdir do |dir|
      project_name = File.join(dir, "existing_project")
      FileUtils.mkdir_p(project_name)

      generator = described_class.new(
        template: template,
        project_name: project_name,
        git: false,
        force: true
      )

      expect { generator.run }.not_to raise_error
      expect(File.exist?(File.join(project_name, "README.md"))).to be true
    end
  end
end

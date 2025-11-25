# frozen_string_literal: true

require "fileutils"

module Proj
  class ProjectGenerator
    class DirectoryExistsError < StandardError; end

    attr_reader :template, :project_name, :git, :force

    def initialize(template:, project_name:, git: false, force: false)
      @template = template
      @project_name = project_name
      @git = git
      @force = force
    end

    def run
      validate_target_directory
      create_directories
      create_files
      initialize_git if git
    end

    private

    def target_path
      @target_path ||= File.expand_path(project_name)
    end

    def validate_target_directory
      if Dir.exist?(target_path) && !force
        raise DirectoryExistsError, "Target directory '#{target_path}' already exists. Use --force to reuse it."
      end
    end

    def create_directories
      FileUtils.mkdir_p(target_path)

      template.directories.each do |dir|
        path = File.join(target_path, dir)
        FileUtils.mkdir_p(path)
      end
    end

    def create_files
      template.files.each do |relative_path, content|
        path = File.join(target_path, relative_path)
        parent_dir = File.dirname(path)
        FileUtils.mkdir_p(parent_dir) unless Dir.exist?(parent_dir)
        File.write(path, content)
      end
    end

    def initialize_git
      Dir.chdir(target_path) do
        system("git init > /dev/null 2>&1")
      end
    end
  end
end

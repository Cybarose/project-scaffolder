# frozen_string_literal: true

require "fileutils"

module Proj
  class ReadmeGenerator
    class ReadmeExistsError < StandardError; end

    attr_reader :project_name, :target_dir, :description, :force

    def initialize(project_name:, target_dir:, description: nil, force: false)
      @project_name = project_name
      @target_dir = File.expand_path(target_dir)
      @description = description
      @force = force
    end

    def run
      FileUtils.mkdir_p(target_dir)
      path = File.join(target_dir, "README.md")

      if File.exist?(path) && !force
        raise ReadmeExistsError, "README.md already exists at '#{path}'. Use --force to overwrite."
      end

      File.write(path, build_content)
    end

    private

    def build_content
      lines = []
      lines << "# #{project_name}"
      lines << ""
      lines << (description.to_s.strip.empty? ? "Short description of the project." : description.strip)
      lines << ""
      lines << "## Overview"
      lines << ""
      lines << "Explain the purpose of the project, its main features, and the context in which it is used."
      lines << ""
      lines << "## Installation"
      lines << ""
      lines << "Describe how to install dependencies, set up the environment, and run the project."
      lines << ""
      lines << "## Usage"
      lines << ""
      lines << "Provide examples of how to run the application and typical usage scenarios."
      lines << ""
      lines << "## Development"
      lines << ""
      lines << "Document how to work on the codebase, run tests, and contribute changes."
      lines << ""
      lines << "## License"
      lines << ""
      lines << "State the license under which the project is distributed."
      lines << ""
      lines.join("\n")
    end
  end
end

# frozen_string_literal: true

require "optparse"

module Proj
  class CLI
    def self.start(argv)
      new(argv).run
    end

    def initialize(argv)
      @argv = argv.dup
    end

    def run
      command = @argv.shift

      case command
      when "init"
        run_init(@argv)
      when "list"
        run_list(@argv)
      when "version"
        run_version(@argv)
      when "readme"
        run_readme(@argv)
      when "help", "-h", "--help", nil
        print_help
      else
        $stderr.puts "Unknown command: #{command}"
        print_help
        exit 1
      end
    rescue StandardError => e
      $stderr.puts "Error: #{e.message}"
      exit 1
    end

    private

    # --------------------------------------------------------------------------
    # init
    # --------------------------------------------------------------------------

    def run_init(argv)
      options = {
        template: "generic",
        git: false,
        force: false
      }

      parser = OptionParser.new do |opts|
        opts.banner = "Usage: proj init NAME [options]"

        opts.on("-t", "--template NAME", "Template name to use") do |value|
          options[:template] = value
        end

        opts.on("--git", "Initialize a Git repository in the project directory") do
          options[:git] = true
        end

        opts.on("-f", "--force", "Allow using an existing directory") do
          options[:force] = true
        end

        opts.on("-h", "--help", "Show help for init") do
          puts opts
          exit
        end
      end

      project_name = argv.shift
      unless project_name
        $stderr.puts "Missing project name."
        puts parser
        exit 1
      end

      parser.parse!(argv)

      template_store = TemplateStore.default
      template = template_store.fetch(options[:template])

      generator = ProjectGenerator.new(
        template: template,
        project_name: project_name,
        git: options[:git],
        force: options[:force]
      )

      generator.run

      puts "Project '#{project_name}' created with template '#{template.name}'."
    end

    # --------------------------------------------------------------------------
    # list
    # --------------------------------------------------------------------------

    def run_list(argv)
      parser = OptionParser.new do |opts|
        opts.banner = "Usage: proj list [options]"

        opts.on("-h", "--help", "Show help for list") do
          puts opts
          exit
        end
      end

      parser.parse!(argv)

      template_store = TemplateStore.default
      templates = template_store.all

      puts "Available templates:"
      puts
      templates.each do |template|
        puts "  #{template.name}"
        puts "    #{template.description}"
        puts
      end
    end

    # --------------------------------------------------------------------------
    # version
    # --------------------------------------------------------------------------

    def run_version(argv)
      parser = OptionParser.new do |opts|
        opts.banner = "Usage: proj version"
        opts.on("-h", "--help", "Show help for version") do
          puts opts
          exit
        end
      end

      parser.parse!(argv)
      puts Proj::VERSION
    end

    # --------------------------------------------------------------------------
    # readme
    # --------------------------------------------------------------------------

    def run_readme(argv)
      options = {
        dir: nil,
        description: nil,
        force: false
      }

      parser = OptionParser.new do |opts|
        opts.banner = "Usage: proj readme NAME [options]"

        opts.on("-d", "--dir PATH", "Target directory for README.md (defaults to NAME)") do |value|
          options[:dir] = value
        end

        opts.on("--description TEXT", "Short project description to include in the README") do |value|
          options[:description] = value
        end

        opts.on("-f", "--force", "Overwrite an existing README.md if present") do
          options[:force] = true
        end

        opts.on("-h", "--help", "Show help for readme") do
          puts opts
          exit
        end
      end

      project_name = argv.shift
      unless project_name
        $stderr.puts "Missing project name."
        puts parser
        exit 1
      end

      parser.parse!(argv)

      target_dir = options[:dir] || project_name

      generator = ReadmeGenerator.new(
        project_name: project_name,
        target_dir: target_dir,
        description: options[:description],
        force: options[:force]
      )

      generator.run

      puts "README.md generated at '#{File.join(File.expand_path(target_dir), "README.md")}'."
    end

    # --------------------------------------------------------------------------
    # help
    # --------------------------------------------------------------------------

    def print_help
      puts <<~HELP
        proj - project initializer

        Usage:
          proj <command> [options]

        Commands:
          init NAME      Initialize a new project using a template
          list           List available templates
          readme NAME    Generate a README.md skeleton for a project
          version        Print the current version
          help           Show this help message

        Run 'proj <command> --help' for more information on a command.
      HELP
    end
  end
end

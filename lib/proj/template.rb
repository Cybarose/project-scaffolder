# frozen_string_literal: true

module Proj
    class Template
      attr_reader :name, :description, :directories, :files, :post_init_commands
  
      def initialize(name:, description:, directories:, files:, post_init_commands: [])
        @name = name
        @description = description
        @directories = directories.freeze
        @files = files.freeze
        @post_init_commands = post_init_commands.freeze
      end
    end
  end
  
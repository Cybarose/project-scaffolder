# frozen_string_literal: true

module Proj
  class TemplateStore
    def self.default
      new(default_templates)
    end

    # --------------------------------------------------------------------------
    # Default templates
    # --------------------------------------------------------------------------

    def self.default_templates
      [
        # ----------------------------------------------------------------------
        # Ruby template
        # ----------------------------------------------------------------------
        Template.new(
          name: "ruby",
          description: "Basic Ruby project with RSpec and bin/lib/spec structure.",
          directories: %w[lib spec bin],
          files: {
            "Gemfile" => <<~GEMFILE,
              source "https://rubygems.org"

              gem "rspec"
            GEMFILE
            "README.md" => <<~README,
              # New Ruby Project

              Describe your Ruby project here.
            README
            ".gitignore" => <<~GITIGNORE
              /.bundle
              /vendor/
              *.log
            GITIGNORE
          }
        ),

        # ----------------------------------------------------------------------
        # Python template
        # ----------------------------------------------------------------------
        Template.new(
          name: "python",
          description: "Python project with src/tests layout and requirements.txt.",
          directories: %w[src tests],
          files: {
            "requirements.txt" => "",
            "README.md" => <<~README,
              # New Python Project

              Describe your Python project here.
            README
            ".gitignore" => <<~GITIGNORE
              __pycache__/
              *.pyc
              .env
            GITIGNORE
          }
        ),

        # ----------------------------------------------------------------------
        # ESP32 template
        # ----------------------------------------------------------------------
        Template.new(
          name: "esp32",
          description: "ESP32 project structure suitable for PlatformIO or similar tools.",
          directories: %w[src include lib docs],
          files: {
            "README.md" => <<~README,
              # ESP32 Project

              Describe your ESP32 project setup and hardware here.
            README
            ".gitignore" => <<~GITIGNORE
              .pio/
              .vscode/
              *.log
            GITIGNORE
          }
        ),

        # ----------------------------------------------------------------------
        # Generic template
        # ----------------------------------------------------------------------
        Template.new(
          name: "generic",
          description: "Minimal generic project with src and docs.",
          directories: %w[src docs],
          files: {
            "README.md" => <<~README,
              # New Project

              Describe your project here.
            README
            ".gitignore" => <<~GITIGNORE
              *.log
              .DS_Store
            GITIGNORE
          }
        ),

        # ----------------------------------------------------------------------
        # Node.js template
        # ----------------------------------------------------------------------
        Template.new(
          name: "node",
          description: "Node.js project with src/tests, package.json, and eslint config.",
          directories: %w[src tests],
          files: {
            "package.json" => <<~JSON,
              {
                "name": "node-project",
                "version": "1.0.0",
                "main": "src/index.js",
                "license": "MIT",
                "scripts": {
                  "test": "echo \\"No tests configured\\""
                }
              }
            JSON
            ".gitignore" => <<~IGNORE,
              node_modules/
              *.log
            IGNORE
            "README.md" => <<~README
              # Node.js Project

              Describe your Node.js project here.
            README
          }
        ),

        # ----------------------------------------------------------------------
        # Python Docker template
        # ----------------------------------------------------------------------
        Template.new(
          name: "python-docker",
          description: "Python project including Dockerfile and requirements.txt, ready for container deployment.",
          directories: %w[src],
          files: {
            "Dockerfile" => <<~DOCKER,
              FROM python:3.11-slim
              WORKDIR /app
              COPY . .
              RUN pip install -r requirements.txt
              CMD ["python3", "src/main.py"]
            DOCKER
            "requirements.txt" => "",
            "src/main.py" => "# Entry point for the Python application",
            ".gitignore" => "__pycache__/\n*.pyc\n.env\n",
            "README.md" => <<~README
              # Dockerized Python Project

              Describe your Python project here.
            README
          }
        ),

        # ----------------------------------------------------------------------
        # Web Frontend template
        # ----------------------------------------------------------------------
        Template.new(
          name: "web-frontend",
          description: "Frontend template with HTML/CSS/JS and basic project structure.",
          directories: %w[src assets/css assets/js],
          files: {
            "src/index.html" => <<~HTML,
              <!DOCTYPE html>
              <html lang="en">
              <head>
                <meta charset="UTF-8" />
                <title>Web Frontend Project</title>
                <link rel="stylesheet" href="../assets/css/style.css" />
              </head>
              <body>
                <h1>Web Frontend Project</h1>
                <script src="../assets/js/app.js"></script>
              </body>
              </html>
            HTML
            "assets/css/style.css" => "/* Add your styles here */",
            "assets/js/app.js" => "// JavaScript entry point",
            "README.md" => "# Web Frontend Project\n",
            ".gitignore" => "node_modules/\n.DS_Store\n"
          }
        ),

        # ----------------------------------------------------------------------
        # Rust template
        # ----------------------------------------------------------------------
        Template.new(
          name: "rust",
          description: "Basic Rust project with Cargo.toml and src/main.rs.",
          directories: %w[src],
          files: {
            "Cargo.toml" => <<~TOML,
              [package]
              name = "rust_project"
              version = "0.1.0"
              edition = "2021"
            TOML
            "src/main.rs" => <<~RS,
              fn main() {
                  println!("Hello from Rust project!");
              }
            RS
            ".gitignore" => "target/\n",
            "README.md" => "# Rust Project\n"
          }
        ),

        # ----------------------------------------------------------------------
        # Go template
        # ----------------------------------------------------------------------
        Template.new(
          name: "go",
          description: "Simple Go module with main.go and go.mod.",
          directories: %w[cmd src],
          files: {
            "go.mod" => "module go_project\n\ngo 1.21",
            "cmd/main.go" => <<~GO,
              package main

              import "fmt"

              func main() {
                  fmt.Println("Hello from Go project!")
              }
            GO
            ".gitignore" => "bin/\n*.log\n",
            "README.md" => "# Go Project\n"
          }
        ),

        # ----------------------------------------------------------------------
        # C++ template with CMake
        # ----------------------------------------------------------------------
        Template.new(
          name: "cpp",
          description: "C++ project using CMake with src/include layout.",
          directories: %w[src include],
          files: {
            "CMakeLists.txt" => <<~CMAKE,
              cmake_minimum_required(VERSION 3.15)
              project(cpp_project)
              set(CMAKE_CXX_STANDARD 20)

              add_executable(cpp_project src/main.cpp)
            CMAKE
            "src/main.cpp" => <<~CPP,
              #include <iostream>

              int main() {
                  std::cout << "Hello from C++ project!" << std::endl;
                  return 0;
              }
            CPP
            ".gitignore" => "build/\n",
            "README.md" => "# C++ Project\n"
          }
        )
      ]
    end

    # --------------------------------------------------------------------------
    # Store implementation
    # --------------------------------------------------------------------------

    def initialize(templates)
      @templates = {}
      templates.each do |template|
        @templates[template.name] = template
      end
    end

    def all
      @templates.values
    end

    def fetch(name)
      template = @templates[name]
      return template if template

      available = @templates.keys.sort.join(", ")
      raise ArgumentError, "Unknown template '#{name}'. Available templates: #{available}"
    end
  end
end

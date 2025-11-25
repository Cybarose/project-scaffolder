# project-scaffolder
`project-scaffolder` is a modular Ruby-based command-line tool designed to quickly initialize new software projects from predefined templates. It provides consistent directory structures, essential starter files, optional Git initialization, and a dedicated README generator for both new and existing projects. The tool is built with a RSpec test suite for maintainability and reliability.

## Features
- Generate new projects using predefined templates:
  - Ruby
  - Python
  - Python (Dockerized)
  - ESP32 / PlatformIO
  - Node.js
  - Web Frontend (HTML/CSS/JS)
  - Rust
  - Go
  - C++ (CMake)
  - Generic template
- Automatic creation of project directories and starter files
- Optional Git repository initialization (`--git`)
- Built-in README generator:
  - Creates a professional README.md skeleton
  - Supports custom descriptions
  - Overwrite protection unless `--force` is used
- Modular architecture (CLI, template store, project generator, README generator)
- Complete RSpec test suite covering core functionality

## Installation (local development)
Clone the repository:
git clone https://gitlab.com/<your-namespace>/project-scaffolder.git
cd project-scaffolder

Install dependencies locally (recommended):
bundle install --path vendor/bundle

Make the CLI executable:
chmod +x bin/proj

Run any command using Bundler:
bundle exec bin/proj help

Optionally make the command globally available for the session:
export PATH="$PWD/bin:$PATH"

## Usage
### List available templates
proj list

### Create a new project
proj init my_app --template ruby --git
proj init imu-tool --template esp32
proj init web-demo --template web-frontend

### Generate a README.md for an existing project
proj readme my_app --dir my_app

With custom description:
proj readme ml-service --dir ml-service --description "Small ML microservice with Docker support."

Force overwrite:
proj readme my_app --dir my_app --force

### Print version
proj version

## Project Structure
lib/
  proj.rb
  proj/cli.rb
  proj/template.rb
  proj/template_store.rb
  proj/project_generator.rb
  proj/readme_generator.rb
spec/
  proj/*_spec.rb
bin/
  proj

## Running Tests
Run the full RSpec suite:
bundle exec rspec

Expected output:
11 examples, 0 failures

## Templates Overview
Templates define:
- Directory structure
- Starter files
- Optional build configurations
- README and .gitignore presets

Templates can be extended or modified in:
lib/proj/template_store.rb

## Development
Install dependencies:
bundle install --path vendor/bundle

Run the CLI through Bundler:
bundle exec bin/proj <command>

Add new templates or extend functionality in the lib/proj directory.
Write additional tests in spec/proj.

## License
This project is licensed under the MIT License.

## Motivation
`project-scaffolder` was created to streamline the initialization of new software projects and improve developer experience. It demonstrates clean architecture, modular design, CLI tooling, and thorough testing practices using RSpec.

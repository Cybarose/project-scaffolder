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

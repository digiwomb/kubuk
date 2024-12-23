# KUbuK

[![Version](https://img.shields.io/github/tag/digiwomb/kubuk.svg?maxAge=360&label=version)](https://github.com/digiwomb/kubuk/releases/latest)
[![License](https://img.shields.io/github/license/digiwomb/kubuk.svg)](https://github.com/digiwomb/kubuk/blob/main/LICENSE)
[![GitHub Issues or Pull Requests](https://img.shields.io/github/issues-pr/digiwomb/kubuk)](https://github.com/digiwomb/kubuk)


KUbuK stands for **K**asm **Ubu**ntu with **K**DE. This setup combines the Kasm workspaces environment, an Ubuntu operating system, and the KDE desktop environment, offering a flexible and user-friendly interface tailored for diverse needs.

This Docker image is designed to be a versatile base for an development environment, fully optimized for use with **Kasm Workspaces**. It includes a wide range of pre-installed tools and configurations, making it ideal for developers, system administrators, and power users.

## Base Image

The image is built upon the **lscr.io/linuxserver/webtop:ubuntu-kde** base image, leveraging its lightweight KDE desktop environment for an optimal user experience.

## Configuration recommendation

I recommend copying the "Ubuntu KDE" workspace from https://kasmregistry.linuxserver.io and then entering digiwomb/kubuk:latest as the Docker image. I would also enter the following under "Docker Exec Config".

    {
        "first_launch": {
            "cmd": "bash -c 'rm -rf ~/.config/chromium/Singleton*'"
        }
    }

This will delete any active Chromium sessions before the desktop is started. These sessions can remain because Chromium is not completely terminated when the desktop is destroyed.

## Included Software

### Core Tools and Utilities
- **Homebrew**: A versatile package manager to install and manage development tools and libraries.
- **Ungoogled Chromium**: A privacy-focused Chromium browser variant for secure web browsing.
- **Visual Studio Code (VS Code)**: A flexible, powerful code editor with essential extensions pre-installed (see below).
- **KeepassXC**: A secure and open-source password manager.
- **Termius**: A modern SSH client for managing remote servers.
- **GitHub desktop**: 
- Common utilities: `curl`, `git`, `wget`, `unzip`, `gnupg`, `build-essential`, `htop`, `net-tools` and certificate management tools.

### Homebrew Integration
Homebrew is pre-installed for the **kasm-user** and configured in the environment. It can be used to easily install and manage additional software and libraries. The image includes:
- **GCC**: Installed via Homebrew to support a variety of development tasks.

### Pre-installed VS Code Extensions
To enhance the development experience, the following VS Code extensions are pre-installed:
1. **DevDB** (`damms005.devdb`): A database management tool integrated into VS Code.
2. **GitLens** (`eamodio.gitlens`): Provides powerful Git insights and collaboration tools.
3. **EditorConfig** (`editorconfig.editorconfig`): Helps maintain consistent coding styles.
4. **Prettier** (`esbenp.prettier-vscode`): A code formatter for clean and consistent code.
5. **L13 Diff** (`l13rary.l13-diff`): Allows file and folder comparison.
6. **Git Graph** (`mhutchie.git-graph`): Visualizes Git repositories as interactive graphs.
7. **YAML** (`redhat.vscode-yaml`): Adds YAML file support with schema validation and Intellisense.
8. **Intellicode API Usage Examples** (`visualstudioexptteam.intellicode-api-usage-examples`): Demonstrates smart API usage with IntelliCode.
9. **IntelliCode** (`visualstudioexptteam.vscodeintellicode`): AI-powered suggestions for smarter coding.
10. **Markdown All in One** (`yzhang.markdown-all-in-one`): A comprehensive Markdown solution with preview, shortcuts, and ToC generation.

### Additional Configurations
- **Firefox Removal**: The default Firefox browser has been removed to streamline the environment.

## Purpose

This image is designed for users who need:
- A ready-to-use development environment with tools for programming, remote server management, and secure credential handling.
- The flexibility to install additional software via Homebrew.
- Seamless integration with Kasm Workspaces for performance and productivity.


---

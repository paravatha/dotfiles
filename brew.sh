#!/bin/bash

# 1. Install Homebrew if not present
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

echo "Updating Homebrew..."
brew update

# 2. Core CLI Tools for AI/MLOps
echo "Installing CLI tools..."

brew install \
    uv \
    kubectl \
    helm \
    terraform \
    gh \
    jq \
    awscli \
    azure-cli \
    ollama \
    git \
    krew \
    kube-ps1 \
    zsh

# 3. GUI Applications (Casks)
echo "Installing Applications..."

brew install --cask \
    visual-studio-code \
    docker \
    iterm2 \
    raycast \
    slack

# 4. VS Code Extensions for AI & Infrastructure

echo "Installing VS Code extensions..."
code --install-extension ms-python.python
code --install-extension ms-kubernetes-tools.vscode-kubernetes
code --install-extension hashicorp.terraform
code --install-extension GitHub.copilot
code --install-extension ms-azuretools.vscode-docker

# 5. Initialize uv shell completion

echo "Setting up uv..."
echo 'eval "$(uv generate-shell-completion zsh)"' >> ~/.zshrc

# 6 Oh My Zsh Installation
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "Setup Complete! Please restart your terminal."
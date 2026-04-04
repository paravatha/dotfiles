#!/bin/bash
set -e

# Helper function to install or upgrade a formula
install_or_upgrade_formula() {
    local package=$1
    if brew list "$package" &>/dev/null; then
        echo "Upgrading $package..."
        brew upgrade "$package" || true
    else
        echo "Installing $package..."
        brew install "$package"
    fi
}

# Helper function to install or upgrade a cask
install_or_upgrade_cask() {
    local package=$1
    if brew list --cask "$package" &>/dev/null; then
        echo "Upgrading $package..."
        brew upgrade --cask "$package" || true
    else
        echo "Installing $package..."
        brew install --cask "$package"
    fi
}

# Helper function to install or upgrade VS Code extension
install_or_upgrade_vscode_extension() {
    local extension=$1
    if code --list-extensions | grep -qi "^${extension}$"; then
        echo "Updating $extension..."
    fi
    code --install-extension "$extension" &>/dev/null
}

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
echo "Processing CLI tools..."

declare -a cli_tools=(
    "uv"
    "kubectl"
    "helm"
    "terraform"
    "gh"
    "jq"
    "awscli"
    "azure-cli"
    "ollama"
    "git"
    "krew"
    "kube-ps1"
    "zsh"
)

for tool in "${cli_tools[@]}"; do
    install_or_upgrade_formula "$tool"
done

# 3. GUI Applications (Casks)
echo "Processing Applications..."

declare -a cask_apps=(
    "visual-studio-code"
    "docker"
    "slack"
    "rectangle"
)

for app in "${cask_apps[@]}"; do
    install_or_upgrade_cask "$app"
done

# 4. VS Code Extensions for AI & Infrastructure
if command -v code &>/dev/null; then
    echo "Processing VS Code extensions..."
    
    declare -a vscode_extensions=(
        "ms-python.python"
        "ms-kubernetes-tools.vscode-kubernetes"
        "hashicorp.terraform"
        "GitHub.copilot"
        "ms-azuretools.vscode-docker"
    )
    
    for extension in "${vscode_extensions[@]}"; do
        install_or_upgrade_vscode_extension "$extension"
    done
else
    echo "VS Code not found. Skipping extension installation."
fi

# 5. Initialize uv shell completion
echo "Setting up uv..."
if ! grep -q 'uv generate-shell-completion' ~/.zshrc; then
    echo 'eval "$(uv generate-shell-completion zsh)"' >> ~/.zshrc
fi

# 6. Oh My Zsh Installation
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "Oh My Zsh already installed."
fi

echo "Setup Complete! Please restart your terminal."
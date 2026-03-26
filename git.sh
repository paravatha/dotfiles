#!/bin/bash
set -e

###### pre-commit ######

uv pip install pre-commit
pre-commit --version
pre-commit install
pre-commit run --all-files
git config --unset-all core.hooksPath


###### git reset
git reset --hard HEAD
git fetch origin
git rebase origin/main

###### git tags ######
git fetch --tags
git tag -l

git tag -s v0.11.8-dev -m "dev update"
git push origin v0.11.8-dev

git tag -s v0.11.8-int -m "int update"
git push origin v0.11.8-int

git tag -s v0.11.8-prod -m "prd update"
git push origin v0.11.8-prod

# Delete all local tags and get the list of remote tags:
git tag -l | xargs git tag -d
git fetch

# Remove all remote tags
git tag -l | xargs -n 1 git push --delete origin

###### ssh key ######
export EMAIL="example@gmail.com" 
export USERNAME="example"

ssh-keygen -t ed25519 -C "$EMAIL"
eval "$(ssh-agent -s)"
touch ~/.ssh/config

Host github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519

pbcopy < ~/.ssh/id_ed25519.pub

# Add the copied key to GitHub under Settings > SSH and GPG keys > New SSH key

###### GPG setup ######

brew install gnupg
gpg --version
echo "test" | gpg --clearsign

brew install pinentry-mac
echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf
killall gpg-agent || true  # Ignore if gpg-agent not running


gpg --list-secret-keys --keyid-format=long
gpg --full-generate-key

gpg --list-secret-keys --keyid-format=long

# Replace KEY_ID with the long format key ID from the list above
gpg --armor --export KEY_ID

# Add the output to GitHub under Settings > SSH and GPG keys > New GPG key

git config --global user.name "$USERNAME"
git config --global user.email "$EMAIL"
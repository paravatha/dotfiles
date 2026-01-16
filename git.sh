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
ssh-keygen -t ed25519 -C "prasad.paravatha@gmail.com"
eval "$(ssh-agent -s)"
touch ~/.ssh/config

Host github.com
  AddKeysToAgent yes
  IdentityFile ~/.ssh/id_ed25519

  pbcopy < ~/.ssh/id_ed25519.pub

###### GPG setup ######

gpg --version

echo "test" | gpg --clearsign

gpg --list-secret-keys --keyid-format=long

brew install pinentry-mac
echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf
killall gpg-agent

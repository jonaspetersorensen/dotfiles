# nodejs

Use `nvm` to handle nodejs versions

- [nvm](https://github.com/nvm-sh/nvm)

```sh
# Install nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
source $HOME/.bashrc

# List local nodejs versions
nvm list

# Get remote list
nvm list-remote

# Install nodejs version
nvm install v16.14.0

# Verify install
node -v
```
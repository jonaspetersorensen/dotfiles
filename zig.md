# Zig


## Installing

Paths are handled in [`dotfiles/configs/.bashrc_dotfiles`](./configs/.bashrc_dotfiles)


### Install zig  

Zig comes as a directory with multiple files.

1. Go to HOME dir
1. Our install location will be in `$HOME/.local/zig`
   1. Clean out any previous install, run `rm -rf $HOME/.local/zig/*`
1. Get url to release package from [offical download page](https://ziglang.org/download/)
1. Download release package, run `curl -OL <release-package-url>`
1. Unpack the release, run `tar -xf <release-package>`. This will create a new directory with the same name as the release package.
1. Copy files from release package directory into install location, `cp -r <release-package-directory>/* $HOME/.local/zig/`
1. Clean up
   1. `rm -rf <release-package>`
   2. `rm -rf <release-package-dir>
1. Done!


### Install zig language server

ZLS comes as a bin file.

1. Go to HOME dir
1. Our install location will be in `$HOME/bin`
1. Create a tmp dir, `mkdir tmp-zls`
1. Get url to release package from [offical repo releases](https://github.com/zigtools/zls/releases)
1. Download release package, run `curl -OL <release-package-url>`
1. Unpack the release into the tmp dir, run `tar -xf <release-package> --directory tmp-zls`
   Notes on the official instructions: In the docs they use a command option that does not seem to work as intended, `--strip-components=1`, and so we will skip that.
1. Copy the bin file into install location, run `cp -r tmp-zls/zls $HOME/bin/`
1. Clean up, run `rm -rf tmp-zls`
1. Done!

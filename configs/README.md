# Configs

## Shared .bachrc settings

All shared settings are stored in file [`.bashrc_dotfiles`](./.bashrc_dotfiles)

1. Open local `.bashrc`
1. Add  
   ```sh
   ### dotfiles: shared settings
   source "$HOME/dev/dotfiles/configs/.bashrc_dotfiles"
   ### 
   ```

## Other dot files

Create/update symlinks to config files:

1. TMUX: `ln -sf .tmux.conf "$HOME/.tmux.conf"`


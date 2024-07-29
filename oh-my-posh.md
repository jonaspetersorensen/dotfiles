# Oh My Posh

`Oh My Posh` is a very simple, yet effective way to style any shell.  
For my use case it eliminates the need for Oh My ZSH + themes as I really do not use zsh that much.

## WSL

Use case is WSL + Windows Terminal

1. In WSL, run [Oh My Posh linux installation](https://ohmyposh.dev/docs/installation/linux)  
   Follow the default installation as it easy to change theme after initial installation has completed.  
   - For changing themes, see https://ohmyposh.dev/docs/themes
1. In windows, install [MESLO LGM Nerd Font](https://www.nerdfonts.com/font-downloads) (recommended font by Oh My Posh)
   - Unzip then select all font files, right-click and select "install for all users" as they need to by available system wide for Windows Terminal
1. In windows terminal, open settings
   1. Open profile Ubuntu-{version}
   1. Open to tab "Apperance"
   1. Set font to `MesloLGM Nerd Font`
   1. Enable `Show all fonts`
   1. Set color scheme to be `Solarized Dark` 
   1. Save profile
   1. Restart terminal
1. Done!

For instructions with pictures, see https://www.ceos3c.com/wsl-2/windows-terminal-customization-wsl2-deep-dive


## My oh-my-posh customization

- Font: [Mononoki Nerd Font](https://www.nerdfonts.com/font-downloads)  
  Configure: windows terminal settings, ubuntu profile, apperance, fonts
- Theme: `~/.poshthemes/rudolfs-dark.omp.json`, [preview themes](https://ohmyposh.dev/docs/themes)  
  Configuration:  
  1. Create dir for all themes: `mkdir ~/.local/poshthemes`
  1. Download desired theme:  
     1. `cd ~/.local/poshthemes`
     1. `curl -OL https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/main/themes/rudolfs-dark.omp.json` 
  1. Add or edit link to theme to `.bashrc_dotfiles`
     ```sh
     ### OH MY POSH
     eval "$(oh-my-posh --init --shell bash --config ~/.poshthemes/rudolfs-dark.omp.json)"
     ```





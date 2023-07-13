#!/bin/bash

# In order to update tmux then we must first kill the tmux server
# To avoid restarting a new tmux session we will use an empty file "TMUX_UPDATE_IN_PROGRESS" as flag so that any session can read it
# See TMUX in ../configs/.bashrc_dotfiles for how this flag is used

touch "$HOME/TMUX_UPDATE_IN_PROGRESS"
echo "To kill tmux server then:"
echo "1. Exit all sessons"
echo "2. Run tmux kill-server"
echo "3. Now you can update tmux by calling the update script"


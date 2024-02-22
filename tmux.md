# TMUX

`tmux` is installed by default by the install script.  
Note that `tmux` package version seems to be linked to ubuntu version, meaning Ubuntu seems to not update their `tmux` package until they also create a new distro...

## Table of Contents

- [.bashrc](#bashrc)
- [tmux config and mouse support](#tmuxconf)
- [tmux shortcuts & cheatsheet](https://gist.github.com/MohamedAlaa/2961058)


## .bashrc

Add to `.bashrc_extras` to start up `mtux` with the current session name as tmux session name  
Thanks to [reddit/user/SooperBoby/](https://www.reddit.com/r/tmux/comments/ijafxg/bashrc_snippet_for_automatic_tmux_launch_with/)

```sh
### TMUX AUTOMATIC LAUNCH ###
if [ -z "$TMUX" -a "$TERM_PROGRAM" != "vscode" ] ; then

	TERMINAL_EMULATOR="$(basename $(tty))"
	TERMINAL_EMULATOR=${TERMINAL_EMULATOR^^} # Uppercase all letters

	TERMINAL_PROCESS="$(ps -o 'cmd=' -p $(ps -o 'ppid=' -p $$))"

	if [ -x "$TERMINAL_PROCESS" ] ; then
		TERMINAL_EMULATOR=$(basename "$TERMINAL_PROCESS")
		TERMINAL_EMULATOR=${TERMINAL_EMULATOR^} # Uppercase first letter
	elif [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		TERMINAL_EMULATOR="SSH"
	fi

	for i in $(seq -w 1 100) ; do
		if [ "$i" -eq 001 ] ; then
			SESSION_NAME="$TERMINAL_EMULATOR"
		else
			SESSION_NAME="$TERMINAL_EMULATOR-$i"
		fi

		if (exec tmux new -s "$SESSION_NAME") ; then
			break
		fi
	done
fi
###############

```

## .tmux.conf


### Reload config

To make tmux read changes in the config file then you have two options:
- Restart the tmux server `$  tmux kill-server` then restart a new tmux session
- Reload the config file from inside tmux by `CTRL+B` then press `:` to bring up tmux command prompt and run `source-file ~/.tmux.conf`


### Mouse support

To enable mouse support by default then add the following to the tmux config file `.tmux.conf`

```sh
# Enable mouse support
set -g mouse on
```

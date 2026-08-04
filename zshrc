# Alias

# Code
alias p='python3'

# basic
alias sz='source ~/.zshrc'

#eza
alias ls='eza -l --icons --group-directories-first --git --no-permissions --no-user --no-time --no-filesize'
alias lt='eza --tree --level=2 --icons'
alias la='eza -la --icons --group-directories-first --git'
alias ll='eza --icons --group-directories-first'


# App Wrapper
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
# export PATH="$HOME/Downloads/nvim-macos-arm64/bin:$PATH"
export EDITOR="nvim"
export EZA_CONFIG_DIR="$HOME/.config/eza"


function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

brave() {
  open -a "Brave Browser" "$1"
}


#Enable Fzf
source <(fzf --zsh)
#Enable zoxide
eval "$(zoxide init zsh)"

#Enable precmd

# Draw seprartor line based on color (0-255)
# precmd() {
#   print -P "%F{236}${(l:$COLUMNS::─:)}%f"
# }

# Draw a cyan separator line before each prompt
# precmd() {
#   print -P "%F{cyan}${(l:$COLUMNS::─:)}%f"
# }

# Draw a cyan line with white time stamp 
# precmd() {
#   local line=${(l:$COLUMNS::─:)}
#   local timestamp=$(date +%H:%M:%S)
#   print -P "%F{cyan}──── %F{white}$timestamp %F{cyan}${line:0:$((COLUMNS - 15))}%f"
# }

# Draw line, git, time, status
autoload -Uz vcs_info
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '%F{red}●%f'
zstyle ':vcs_info:git:*' stagedstr '%F{green}●%f'
zstyle ':vcs_info:git:*' formats '%F{magenta} %b%u%c%f'

preexec() { cmd_start=$EPOCHSECONDS }

precmd() {
  local exit_code=$?
  vcs_info

  local elapsed=""
  if [[ -n $cmd_start ]]; then
    elapsed="%F{yellow}took $(( EPOCHSECONDS - cmd_start ))s "
    unset cmd_start
  fi

  local status_icon=""
  if [[ $exit_code -ne 0 ]]; then
    status_icon="%F{red}✘ $exit_code "
  else
    status_icon="%F{green}✔ "
  fi

  local line=${(l:$COLUMNS::─:)}
  local timestamp=$(date +%H:%M:%S)
  # print -P "%F{cyan}──── %F{white}%f %F{white}$timestamp ${elapsed}${status_icon}${vcs_info_msg_0_} %F{cyan}${line:0:$((COLUMNS - 40))}%f"
  PROMPT="%F{cyan}──── %F{white}%f %F{white}$timestamp ${elapsed}${status_icon}${vcs_info_msg_0_} %F{cyan}${line:0:$((COLUMNS - 40))}%f"$'\n''%F{green}%6~%f %F{yellow}❯%f '
}


#Enable Vim within zsh
bindkey -v

# beam cursor for insert mode, block cursor for normal mode
zle-keymap-select() {
  if [[ $KEYMAP == vicmd ]]; then
    echo -ne '\e[2 q'  # block cursor
  else
    echo -ne '\e[6 q'  # beam cursor
  fi
}
zle -N zle-keymap-select

# start with beam cursor on each new prompt
zle-line-init() {
  echo -ne '\e[6 q'
}
zle -N zle-line-init

# allow delete for normal'd text
bindkey "^?" backward-delete-char

# change delay mode change
export KEYTIMEOUT=1

# yank to system clipboard in vi mode
vi-yank-clip() {
  zle vi-yank
  echo -n "$CUTBUFFER" | pbcopy
}
zle -N vi-yank-clip
bindkey -M vicmd 'y' vi-yank-clip





export PATH="$HOME/.local/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

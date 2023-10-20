# ----------------------------
# paths
# ----------------------------
typeset -gU PATH path
typeset -gU FPATH fpath

path=(
  '/usr/local/bin'(N-/)
  '/usr/bin'(N-/)
  '/bin'(N-/)
  '/usr/local/sbin'(N-/)
  '/usr/sbin'(N-/)
  '/sbin'(N-/)
)

path=(
  "$HOME/.local/bin"(N-/)
  "$GOPATH/bin"(N-/)
  "$path[@]"
)

fpath=(
  "$XDG_DATA_HOME/zsh/completions"(N-/)
  "$fpath[@]"
)

# ----------------------------
# history
# ----------------------------
HISTFILE="${XDG_CONFIG_HOME}/zsh/.zsh_history"
export HISTSIZE=10000
export SAVEHIST=10000

# ----------------------------
# options
# ----------------------------
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt GLOB_DOTS
setopt APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt INTERACTIVE_COMMENTS
setopt SHARE_HISTORY
setopt PRINT_EIGHT_BIT
setopt NOBEEP

# ----------------------------
# hooks
# ----------------------------
zshaddhistory() {
  local line="${1%%$'\n'}"
  [[ ! "$line" =~ "^(cd|history|la|ll|ls)($| )" ]]
}

# ----------------------------
# theme
# ----------------------------
zinit lucid pick"async.zsh" src"pure.zsh" light-mode for \
  sindresorhus/pure

# ----------------------------
# keybind
# ----------------------------
bindkey -v  # vi mode
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
bindkey '^B' backward-char
bindkey '^F' forward-char
bindkey '^J' down-line-or-history
bindkey '^K' up-line-or-history
bindkey '^Q' push-line-or-edit

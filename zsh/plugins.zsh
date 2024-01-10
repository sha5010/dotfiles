# essentials
zinit wait lucid blockf light-mode for \
  zsh-users/zsh-autosuggestions \
  zsh-users/zsh-completions \
  zdharma-continuum/fast-syntax-highlighting

# load config from prezto
zstyle ':prezto:*:*' color 'yes'
zinit wait lucid blockf is-snippet for \
  PZTM::directory \
  PZTM::utility \
  PZTM::completion

# autopair
zinit wait'1' lucid light-mode for \
  hlissner/zsh-autopair

# history substring search
__zsh_history_substring_search_atload() {
  bindkey "^[[A" history-substring-search-up
  bindkey "^[[B" history-substring-search-down
  bindkey "^[OA" history-substring-search-up
  bindkey "^[OB" history-substring-search-down
  bindkey "^K" history-substring-search-up
  bindkey "^J" history-substring-search-down
}
zinit wait'1' lucid light-mode for \
  atload'__zsh_history_substring_search_atload' \
  zsh-users/zsh-history-substring-search

# enhancd
export ENHANCD_DIR="${XDG_CONFIG_HOME}/enhancd"
export ENHANCD_FILTER="fzf --preview 'eza --tree --group-directories-first --level 1 --colour=always {}'"
zinit wait lucid light-mode for \
  pick'init.sh' b4b4r07/enhancd

# zsh-vi-mode
zvm_config() {
  export ZVM_INIT_MODE=sourcing
  export ZVM_KEYTIMEOUT=1
  export ZVM_VI_SURROUND_BINDKEY="s-prefix"
}
zvm_after_init() {
  bindkey -M viins "^K" history-substring-search-up
}
zinit wait'0' lucid light-mode depth'1' for \
  jeffreytse/zsh-vi-mode

# ripgrep
zinit wait lucid light-mode as'program' from'gh-r' for \
    pick'ripgrep*/rg' \
    BurntSushi/ripgrep \

# eza
__eza_atload() {
  alias ls='eza -Fg --group-directories-first --time-style=long-iso --git'
  alias la='ls -la --icons=auto'
  alias ll='ls -l --icons=auto'
  alias l='ls -1'
  alias tree='ls --tree --icons=auto'
}
zinit wait lucid light-mode as'program' from'gh-r' for \
  if'[[ "$OSTYPE" =~ "linux" ]]' \
  pick'bin/eza' \
  atload'__eza_atload' \
  eza-community/eza
zinit wait lucid is-snippet as'completion' pick'_eza' for \
  https://raw.githubusercontent.com/eza-community/eza/main/completions/zsh/_eza

# fzf
__fzf_atload() {
  export FZF_DEFAULT_OPTS='--reverse --border --ansi --no-separator --info=inline --cycle --scrollbar=▐'
  export FZF_DEFAULT_COMMAND='fd --hidden --color=always'
  export FZF_COMPLETION_OPTS="--info=inline"
  export RUNEWIDTH_EASTASIAN=0
}
zinit wait lucid light-mode as'program' from'gh-r' for \
  pick'fzf/fzf' \
  atload'__fzf_atload' \
  @'junegunn/fzf'

__fzf_keybind_adload() {
  bindkey -M vicmd '^R' redo
  bindkey -M vicmd '/'  fzf-history-widget
  bindkey -M vicmd '?'  fzf-history-widget
}
zinit wait'1' lucid is-snippet for \
    https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh \
  atload'__fzf_keybind_adload' \
    https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh

_fzf_compgen_path() {
  fd --hidden --follow \
    --exclude .git -E node_module -E __pycache__ \
    . "$1" 2>/dev/null | sed 's@^\./@@'
}
_fzf_compgen_dir() {
  fd --hidden --follow --type d \
    --exclude .git -E node_module -E __pycache__ \
    . "$1" 2>/dev/null | sed 's@^\./@@'
}
_fzf_comprun() {
  local command=$1
  shift

  local tree='eza --tree --group-directories-first --level 1 --colour=always {}'
  case "$command" in
    cd|rmdir|pushd) fzf --preview "$tree" "$@" ;;
    export|unset)   fzf --preview "eval 'echo \$'{}" "$@" ;;
    kill|ps)        fzf --preview 'ps --pid={} u' "@$" ;;
    *)              fzf --preview "[ -d {} ] && $tree || bat --color=always -n --line-range=:500 {}" "$@" ;;
  esac
}

# fzf-tab
zstyle ':completion:*:descriptions' format
zstyle ':fzf-tab:complete:_zlua:*' query-string input
zstyle ':fzf-tab:complete:*' fzf-bindings \
  'ctrl-f:page-down' \
  'ctrl-b:page-up' \
  'space:accept'
zstyle ':fzf-tab:complete:*' fzf-flags --info=inline
zstyle ':fzf-tab:complete:*' fzf-min-height 10
zstyle ':fzf-tab:*' prefix ''
zstyle ':fzf-tab:*' show-group none
zstyle ':fzf-tab:*' continuous-trigger '/'
zinit wait lucid blockf light-mode for \
  Aloxaf/fzf-tab

# fzf-tab preview
zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:(cd|rmdir|pushd|*::cd):*' fzf-preview \
  'eza --tree --group-directories-first --level 1 --colour=always $realpath'
zstyle ':fzf-tab:complete:(ls|cat|bat|less|*vim|eza):*' fzf-preview \
  '[ -d $realpath ] && eza --tree --group-directories-first --level 1 --colour=always $realpath || bat --color=always -n --line-range=:500 $realpath'
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	fzf-preview 'echo ${(P)word}'

# bat
__bat_atload() {
  export MANPAGER="sh -c 'col -bx | bat --color=always --language=man --plain'"
  alias cat='bat -pp'
}
zinit wait lucid light-mode as'program' from'gh-r' for \
  mv'bat* -> bat' \
  pick'bat*/bat' \
  atclone'cp -f bat/autocomplete/bat.zsh _bat' atpull'%atclone' \
  atload'__bat_atload' \
  @'sharkdp/bat'

# fd
zinit wait lucid light-mode as'program' from'gh-r' for \
  mv'fd* -> fd' \
  pick'fd/fd' \
  @'sharkdp/fd'

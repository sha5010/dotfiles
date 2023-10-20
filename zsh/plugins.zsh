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
  bindkey "^K" history-substring-search-up
  bindkey "^J" history-substring-search-down
}
zinit wait'1' lucid light-mode for \
  atload'__zsh_history_substring_search_atload' \
  zsh-users/zsh-history-substring-search

# zsh-interactive-cd
zinit wait lucid is-snippet for \
  https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/plugins/zsh-interactive-cd/zsh-interactive-cd.plugin.zsh

# enhancd
export ENHANCD_DIR="${XDG_CONFIG_HOME}/enhancd"
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
zinit wait lucid light-mode depth'1' for \
  jeffreytse/zsh-vi-mode

# ripgrep
local ARCH="$(uname -i)"
zinit wait lucid light-mode as'program' from'gh-r' for \
  if'[ "$ARCH" = "x86_64" ]' pick'ripgrep*/rg' \
    BurntSushi/ripgrep \
  if'[ "$ARCH" = "aarch64" ]' bpick'*aarch64-unknown-linux-gnu*' pick'rg' \
    microsoft/ripgrep-prebuilt \
  if'[[ "$OSTYPE" =~ "darwin" ]]' bpick"*apple-darwin*" pick"rg" \
    microsoft/ripgrep-prebuilt

# eza
__eza_atload() {
  alias ls='eza -Fg --group-directories-first --time-style=long-iso --git'
  alias la='ls -la --icons'
  alias ll='ls -l --icons'
  alias l='ls -1'
  alias tree='ls --tree --icons'
}
zinit wait lucid light-mode as'program' from'gh-r' for \
  pick'bin/eza' \
  atload'__eza_atload' \
  eza-community/eza
zinit wait lucid is-snippet as'completion' pick'_eza' for \
  https://raw.githubusercontent.com/eza-community/eza/main/completions/zsh/_eza

# fzf
__fzf_atload() {
  export FZF_DEFAULT_OPTS='--reverse --border'
  export FZF_DEFAULT_COMMAND='fd --hidden --color=always'
  alias f="fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}'"
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
  pick'completion.zsh' \
    https://raw.githubusercontent.com/junegunn/fzf/master/shell/completion.zsh \
  atload'__fzf_keybind_adload' \
    https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh

# bat
__bat_atload() {
  export MANPAGER="sh -c 'col -bx | bat --color=always --language=man --plain'"
  alias cat='bat --paging=never --plain --wrap=character'
}
zinit wait lucid light-mode as'program' from'gh-r' for \
  mv'bat* -> bat' \
  pick'bat/bat' \
  atload'__bat_atload' \
  @'sharkdp/bat'

# fd
zinit wait lucid light-mode as'program' from'gh-r' for \
  mv'fd* -> fd' \
  pick'fd/fd' \
  @'sharkdp/fd'

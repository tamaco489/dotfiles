# ========================================================================
# os
# ========================================================================
alias salias="source ~/.zshrc"
alias calias="code ~/.zshrc"

alias cbrain="code ~/Desktop/work/brain"
alias cdot="code ~/dotfiles"

alias cdu="cd ~/Desktop"
alias cdb="cd ~/Desktop/work/brain"
alias cdd="cd ~/dotfiles"


# ========================================================================
# history
# ========================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

setopt share_history # 複数ターミナル間で履歴を共有
setopt hist_ignore_all_dups # 重複するコマンドは履歴に追加しない
setopt hist_ignore_space # スペースで始まるコマンドは履歴に追加しない
setopt hist_reduce_blanks # 履歴に保存するとき余分なスペースを削除


# =================================================================
# zsh plugins
# =================================================================
# コマンドのシンタックスハイライト
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# 過去のコマンド履歴から自動補完候補を表示
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh


# =================================================================
# starship
# =================================================================
eval "$(starship init zsh)"
alias set_starship="code ~/.config/starship.toml"


# =================================================================
# fzf
# =================================================================
# fzfのデフォルト設定
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

# fzfのキーバインドと補完機能を有効化
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# =================================================================
# ghq + fzf
# =================================================================
# ghq で管理しているリポジトリに移動する
function g() {
  local repo=$(ghq list | fzf --preview "ls -la $(ghq root)/{}")
  if [ -n "$repo" ]; then
    cd "$(ghq root)/$repo"
  fi
}

# github の remote repository の一覧を取得する
alias ghr="gh api --paginate /user/repos --jq '.[].full_name' | fzf"


# =================================================================
# git/gh/ghq
# =================================================================
# [git]
# general
alias gitcfu="git config --local user.name 'tamaco489'"
alias gitcfe="git config --local user.email 'tamaco489@gmail.com'"

# tag
alias gittl="git tag -l --sort=-v:refname | head -n 3"

# commit
alias gitrph="git rev-parse HEAD"
alias gitrpsh="git rev-parse --short HEAD"

# log
alias glout="git log --oneline" # 一行表示
alias glgraph="git log --graph" # グラフで表示
alias glgraphdeco="git log --graph --oneline --decorate" # 詳細なグラフで表示
alias glnsts="git log --name-status" # 変更ファイルを表示

# [gh]
alias ghal="gh auth login"
alias ghpr="gh pr list"
alias ghprc="gh auth status"
alias ghauth="gh auth token"

# [ghq]
# ローカルのリポジトリを表示
alias ghql="ghq list -p"


# ========================================================================
# aws cli
# ========================================================================
# s3
create-tfstate-bucket() {
  local AWS_PROFILE="$1"
  local AWS_BUCKET_NAME="$2"
  if [[ -z "$AWS_PROFILE" || -z "$AWS_BUCKET_NAME" ]]; then
    echo "使い方: create-tfstate-bucket <AWS_PROFILE> <AWS_BUCKET_NAME>"
    echo "例) $ create-tfstate-bucket my-profile my-tfstate-bucket"
    return 1
  fi
  echo "S3 バケット '$AWS_BUCKET_NAME' を作成します."
  AWS_PROFILE="$AWS_PROFILE" aws s3 mb s3://"$AWS_BUCKET_NAME"
  echo "S3 バケット '$AWS_BUCKET_NAME' のバージョニングを有効化します."
  AWS_PROFILE="$AWS_PROFILE" aws s3api put-bucket-versioning \
      --bucket "$AWS_BUCKET_NAME" \
      --versioning-configuration Status=Enabled
}

delete-tfstate-bucket() {
  local AWS_PROFILE="$1"
  local AWS_BUCKET_NAME="$2"
  if [[ -z "$AWS_PROFILE" || -z "$AWS_BUCKET_NAME" ]]; then
    echo "使い方: delete-tfstate-bucket <AWS_PROFILE> <AWS_BUCKET_NAME>"
    echo "例) $ delete-tfstate-bucket my-profile my-tfstate-bucket"
    return 1
  fi
  echo "S3 バケット '$AWS_BUCKET_NAME' のすべてのオブジェクトを削除します..."
  AWS_PROFILE="$AWS_PROFILE" aws s3 rm s3://"$AWS_BUCKET_NAME" --recursive
  echo "S3 バケット '$AWS_BUCKET_NAME' を削除します..."
  AWS_PROFILE="$AWS_PROFILE" aws s3 rb s3://"$AWS_BUCKET_NAME"
}


# ========================================================================
# claude
# ========================================================================
alias claude-auto='claude --dangerously-skip-permissions'
alias claude-mine='code ~/.claude/CLAUDE.md'


# ========================================================================
# docker
# ========================================================================
alias dspa="docker system prune -a"
alias dvpa="docker volume prune -a"


# ========================================================================
# markdown
# ========================================================================
alias md-lint="markdownlint-cli2"
alias md-lint-cnf="code ~/.markdownlint.yaml"


# ========================================================================
# language
# ========================================================================
export PATH="/opt/homebrew/opt/python@3.12/libexec/bin:$PATH"


# ========================================================================
# asdf
# ========================================================================
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# asdf golang - go install したバイナリを PATH に追加
export GOBIN="$(asdf where golang 2>/dev/null)/bin"
export PATH="${GOBIN}:${PATH}"


# ========================================================================
# local (git 管理外・シークレット)
# ========================================================================
[ -f ~/.zshrc.local ] && source ~/.zshrc.local

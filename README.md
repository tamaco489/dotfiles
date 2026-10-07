# dotfiles

macOS (Apple Silicon) 向けの個人 dotfiles。
`install.sh` がこのリポジトリ内の設定ファイルをホームディレクトリへシンボリックリンクする。

## セットアップ

### 1. 依存ツールのインストール

```sh
# Homebrew (未導入の場合)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew install git gh ghq fzf starship neovim asdf \
  zsh-syntax-highlighting zsh-autosuggestions python@3.12
brew install --cask ghostty
```

### 2. リポジトリの取得とリンク作成

```sh
gh auth login
git clone https://github.com/tamaco489/dotfiles.git ~/dotfiles

# install.sh はリンク先の親ディレクトリを作成しない
mkdir -p ~/.config "$HOME/Library/Application Support/com.mitchellh.ghostty"

bash ~/dotfiles/install.sh
exec zsh
```

| Source                   | Symlink target                                                       |
| ------------------------ | -------------------------------------------------------------------- |
| `zsh/.zshrc`             | `~/.zshrc`                                                           |
| `nvim/`                  | `~/.config/nvim`                                                     |
| `git/.gitconfig`         | `~/.gitconfig`                                                       |
| `starship/starship.toml` | `~/.config/starship.toml`                                            |
| `ghostty/config.ghostty` | `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty` |

### 3. 実行後の作業

- `~/.zshrc.local` を手動で作成する (機密情報・環境依存の設定を置く。git 管理外)
- Go をインストールする

  ```sh
  asdf install golang <version>
  asdf set golang <version>
  go install golang.org/x/tools/gopls@latest
  ```

- fzf のキーバインドを使う場合は `$(brew --prefix)/opt/fzf/install` を実行する
- Neovim の初回起動時に LazyVim がプラグインを自動インストールする

## 注意事項

- `~/.config/nvim` がディレクトリとして既に存在すると、`ln -sf` はその中にリンクを作ってしまい置き換わらない。事前に退避する (`mv ~/.config/nvim ~/.config/nvim.bak`)
- `~/.zshrc` など既存のファイルは上書きされる
- `.zshrc` は `/opt/homebrew/opt/asdf/libexec/asdf.sh` を読み込んでいる。asdf 0.16 以降にはこのファイルがないため、zsh の起動時にエラーになる場合は asdf の設定を修正する
- Homebrew のパスを `/opt/homebrew` と直接書いているので、Intel Mac では動かない

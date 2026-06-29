# CLAUDE.md

このファイルは Claude Code (claude.ai/code) がこのリポジトリで作業する際のガイダンスを提供します。

@.claude/rules/github/commit-types.md
@.claude/rules/github/commit-subject.md
@.claude/rules/github/pr-description.md

## プロジェクト概要

macOS 向けの個人 dotfiles リポジトリ。
`install.sh` がこのリポジトリ内の設定ファイルをホームディレクトリへシンボリックリンクする。

## セットアップ

```sh
bash install.sh
```

| Source                   | Symlink target                                                       |
| ------------------------ | -------------------------------------------------------------------- |
| `zsh/.zshrc`             | `~/.zshrc`                                                           |
| `git/.gitconfig`         | `~/.gitconfig`                                                       |
| `starship/starship.toml` | `~/.config/starship.toml`                                            |
| `ghostty/config.ghostty` | `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty` |

## 構成概要

- **`zsh/.zshrc`** — エイリアス・履歴・プラグイン (zsh-syntax-highlighting, zsh-autosuggestions)・fzf・ghq・git/gh・AWS CLI ヘルパー・asdf PATH 設定。機密情報は `~/.zshrc.local` (git 管理外) に分離し末尾で source する
- **`git/.gitconfig`** — ghq root (`~/src`)・デフォルトブランチ (`main`)
- **`starship/starship.toml`** — プロンプト設定: ディレクトリ省略・git ブランチ/ステータス/メトリクス
- **`ghostty/config.ghostty`** — Ghostty ターミナルの外観設定 (背景透過度など)

## 制約事項

> [!IMPORTANT]
>
> - **即時性は求めない。時間をかけてでも根拠に基づく正確なアウトプットを行う**
> - **公式ドキュメントや関連資料の調査はメインコンテキストを汚さないよう、別途調査用エージェントに委譲する**
> - **コード変更前に必ずファイルを Read ツールで読む**
> - **変更は diff 形式で提示し、承認 (y) を得てから実行する**
> - **git commit はユーザーの承認を得てから実行する**

- 応答は日本語・簡潔・直接的
- コメントは「なぜ」が自明でない場合のみ書く (「何をしているか」は書かない)
- コメントに句点 (。) を含めない

## 禁止事項

- `rm -rf` の使用禁止 — ファイル削除は `rm -f` を使う
- 明示的な指示なしの変更禁止
- `~/.zshrc.local` の読み込み・コミット禁止 — 機密情報・環境依存の設定を含む
- Git フック・署名のスキップ禁止 (`--no-verify`, `--no-gpg-sign`)
- `main` ブランチへの直接 push 禁止
- 絵文字の使用禁止 (明示的に求められた場合を除く)

## 使用バージョン

- Ruby 2.6.6
- Rails 6.0.2.1

## プロジェクトのセットアップ手順

ターミナルでgit cloneして作成されたフォルダに移動して、下記のコマンドを実行してください

- このプロジェクトで使用するGem(Rubyのライブラリ)をインストール
```bash
$ bundle install --path vendor/bundle
```

- データベースの設定を雛形のdefaultファイルをコピーして作成

```bash
$ cp config/database.yml.default config/database.yml
```

- データベースおよびテーブルの作成

```bash
$ bundle exec rails db:setup
```

- rails serverコマンドによるサーバーの起動

```bash
$ bundle exec rails server
```

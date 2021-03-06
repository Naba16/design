#Design Project Team E（開発完了）
デザインプロジェクトBのEチーム用です。  

##開発環境
* Ruby On Rails 4.0.0
* Passenger on Apache2
その他適宜追加します。

## 開発環境の構築と実行

リポジトリをクローンしたあとは，以下のコマンドを実行して，
開発環境を構築する．

```
bundle install --without=production
rake db:setup
```

`rake db:setup` は `rake db:migrate + rake db:seeds`
で，マイグレーションと初期データの投入を一度にやってくれます．
なお，`rake db:setup`し直してエラーが出る場合，
一旦`rake db:drop` でDBを消してからマイグレーションを行うと成功するかもしれません．

サーバーを起動するには以下のコマンドを実行する．

```
rails s
```

## 高速なコマンド実行

`bin` 直下に 'springify' された binstub がおいてある．

```
bin/rails foo
bin/rake foo
```

以上のように実行すると，そのまま実行するより高速に実行できる．

## テスト環境の構築と実行

まずテスト環境のためのデータベーススキーマを構築する．
```
rake db:test:prepare
```

テストの実行は以下のコマンドを打つ．
```
bundle exec rspec path/to/testcase.rb
```
`path/to/testcase.rb` はテストケースのファイルへのパス．
これを省略するとすべてのテストケースを実行する．

## テストの自動化

```
bundle exec guard
```

上記のコマンドを実行するとファイルの変更を監視して，
変更があった際に関連するテストを自動的に実行してくれる．

## UML の生成方法

実行にはgraphvizが必要．
`sudo apt-get install graphviz` で予めインストールしておく．

```
rake diagram:all
```

## Gitコマンドとりあえず

自分(@tatarhy)が使ったことあるやつだけ

### とりあえず現在の状態を見る

```
git status
```

作業ディレクトリの状況を表示する (どのファイルが変更されたか，とか)

```
git branch
```

ブランチの一覧を表示．先頭に`*`があるのがいまいるブランチ．

### コミットログを見る

```
git log
```

現在のブランチだけではなくすべてのログが見たい場合は `--all` オプションをつける．

```
git log --oneline --decorate --graph
```

こんな感じでオプションつけるとログが見やすくなるのでおすすめ．
長いので，自分は以下のコマンドを実行して`lg`をこれのエイリアスにしている．

```
git comfig --global alias.lg 'log --oneline --decorate --graph'`
```

これで， `git lg` とやると同じことができるようになる．

### 元にもどす

```
git reset
```

インデックス(`git add`したら送られるとこ．ここにあるファイルだけがコミットされる)
をaddする前の状態にもどす．

```
git checkout target.file
```

`target.file` を直前のコミット時点の状態までもどす．
なお最後の引数を`.`に換えるとカレントディレクトリ以下のすべてのファイルが対象になる．
なのでプロジェクトのルートのディレクトリで`git checkout .`
とかするとすべてのファイルが元に戻せるのでいいんじゃなかろうか．


### プルして，コミットして，プッシュする

```
git pull
```

リモートリポジトリをローカルにコピーする (リモートとローカルで差分があった場合はマージされる)

```
git add .
git add path/to/modified.file
```

コミットするファイルを指定する

```
git commit -m "Comment for this commit"
```

メッセージ付きでコミットする．最後の`-m`オプションを省略するとエディタが起動する．
どのエディタが起動するかは`$EDITOR`による．

```
git push
```

ローカルのブランチをリモートリポジトリにプッシュする．

### トピックブランチでの作業が終わったので，マスターブランチにマージしたい．

```
git checkout master
git merge --no-ff topic-branch
```

上は`master`ブランチに`topic-branch`ブランチをマージする場合．
`merge`コマンドはいまいるブランチに引数で指定したブランチをマージする．
したがってマージさせたいブランチに`checkout`コマンドで予め移動しておく．

### トピックブランチがちょっと古いので，マスターブランチの変更を取り込みたい

```
git checkout topic-branch
git rebase master
```

### ブランチ操作

```
git checkout -b new-branch
```

`new-branch`を作成して，そこに移動．

```
git checkout one-branch
```

既に存在するブランチに移動する場合は`-b`オプションはいらない．

```
git branch -d one-branch
```

`one-branch`を削除．

```
git push origin new-branch
```

ローカルブランチを新たにリモートにプッシュする場合は上のように，
リモートリポジトリ名とローカルブランチ名を指定してプッシュする．

### その他

色つきのほうが見やすいので色つきで見られるように設定する

```
git config --global color.ui true
```

##連絡等
本番用環境にて、Apache2上でRailsアプリケーションを動かせるように設定しました。  
Apache2が起動していればRailsアプリケーションを個別に起動させる必要はありません。  
現在は`~/rails_test/foo`のRailsアプリケーションを使うようにしています。  
変更方法は、`/etc/apache2/conf.d/passenger`を管理者権限で開いて、  
`DocumentRoot`とその下の`Directory`を`(アプリケーションのパス)/public`に変更し、  
```
sudo /etc/init.d/apache2 restart
```
でApache2を再起動させれば出来ます。

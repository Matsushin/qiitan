# 概要
Qiitaのコピーアプリ

# 本番URL
http://qiitan-prd.herokuapp.com/

# Basic認証
- ユーザ： admin
- パスワード： vdqXhqpuqieJ8kjCqgNYkvGP

### Version
- ruby 2.5.1
- rails 5.1.6
- MySQL 5.7.22

## 初期設定

### インストール
- [Docker for Mac](https://www.docker.com/docker-mac) or [Docker for Windows](https://docs.docker.com/docker-for-windows/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### アプリ初期設定
```
$ docker-compose build
$ docker-compose run web bundle install
```

### データベース初期設定
```
$ docker-compose run web bundle exec rails db:create
$ docker-compose run web bundle exec rails db:migrate
$ docker-compose run web bundle exec rails db:seed
```

## 起動・終了

### 起動コマンド

以下のコマンドで起動します。

```
$ docker-compose up
```

### 終了
Ctrl+C
たまにゴミが残るので、  rm tmp/pid/server.pid を削除する必要があるかも

### DBにmigration
必要なら以下を実行
```
$ docker-compose run web bundle exec rails db:migrate
```
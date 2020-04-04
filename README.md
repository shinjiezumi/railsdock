# バージョン情報
- ruby 2.6.6
- rails 6.0.2.2
- mysql 5.7

# セットアップ手順
1. イメージビルドとコンテナ作製
    ```shell script
    docker-compose up -d
    docker-compose exec app yarn install
    ```
2. `docker-compose.yml`のコメント箇所を有効化
    ```
    #    command: /bin/bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
        command: /bin/bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
    ```
3. コンテナ再起動
    ```shell script
    docker-compose up -d
    ```

# webpack起動
```shell script
docker-compose exec app ./bin/webpack-dev-server
```
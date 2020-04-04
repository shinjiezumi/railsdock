# バージョン情報
- ruby 2.6.6
- rails 6.0.2.2
- mysql 5.7

# セットアップ手順
```shell script
docker-compose build
docker-compose up -d
docker-compose exec web bundle exec rake db:create
docker-compose exec web bundle exec rake db:migrate
docker-compose exec web bundle exec rake db:seed
docker-compose exec web yarn install
```

# webpack起動
```shell script
docker-compose exec web ./bin/webpack-dev-server
```
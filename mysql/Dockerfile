# ベースイメージとしてMySQL公式イメージを使用
FROM mysql:8.0

# 環境変数でMySQLの初期設定を指定
ENV MYSQL_ROOT_PASSWORD=root_password_placeholder
ENV MYSQL_DATABASE=example_db_placeholder
ENV MYSQL_USER=example_user_placeholder
ENV MYSQL_PASSWORD=example_password_placeholder

# ポート3306をコンテナの外部に公開
EXPOSE 3306

# 必要な場合、初期化用のSQLスクリプトをコピー
# 初期化用SQL（例: /docker-entrypoint-initdb.d/init.sql）は、自動的にコンテナ起動時に実行される
# COPY ./init.sql /docker-entrypoint-initdb.d/

# Dockerイメージの起動コマンド（mysql公式イメージデフォルトのENTRYPOINTを使用）
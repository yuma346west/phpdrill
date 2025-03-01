ps:
	docker compose ps
ps-a:
	docker compose ps -a
app-run:
	docker compose up -d frankenphp
down:
	docker compose down
build:
	docker compose build --no-cache frankenphp
login-app:
	docker compose exec frankenphp sh
php-clean:
	docker compose exec frankenphp php artisan config:clear
	docker compose exec frankenphp php artisan cache:clear
	docker compose exec frankenphp php artisan route:clear
	docker compose exec frankenphp php artisan view:clear

migrate:
	docker compose exec frankenphp php artisan migrate

php-test-run:
	docker compose exec frankenphp php artisan test

aws-login-configure:
	aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 949668659243.dkr.ecr.ap-northeast-1.amazonaws.com
ecr-push-php:
	docker build -t phpdrill-repo php
	docker tag phpdrill-repo:latest 949668659243.dkr.ecr.ap-northeast-1.amazonaws.com/phpdrill-repo:latest
	docker push 949668659243.dkr.ecr.ap-northeast-1.amazonaws.com/phpdrill-repo:latest

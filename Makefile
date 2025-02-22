ps:
	docker compose ps
ps-a:
	docker compose ps -a
app-run:
	docker compose up -d
down:
	docker compose down
build:
	docker compose build --no-cache
login-app:
	docker compose exec frankenphp sh
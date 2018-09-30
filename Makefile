docker:
	docker build -t go-test .

build:
	CGO_ENABLED=0 GOOS=linux go build -o app main.go

secret:
	echo "this is a secret" | docker secret create my-secret - 

config:
	echo "this is updated" | docker config create my-config - 

deploy:
	docker stack deploy -c docker-compose.yml hello

stop:
	docker stack rm hello

ps:
	docker service ps hello_server

logs:
	docker service logs hello_server

clean:
	docker system prune --volumes
	docker config rm my-config
	docker secret rm my-secret

VERSION=latest

all:
	go build -o prometheus-example-app 
	docker build -t sysdiglabs/prom-example:latest:$(VERSION) .

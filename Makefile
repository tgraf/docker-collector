.PHONY: tests docker-collector-production docker-collector clean docker-image


KERNEL:= $(shell uname -s)
MACHINE := $(shell uname -m)

tests:
	@godep go test ./...

docker-collector-production: clean tests
	@godep go fmt ./...
	@godep go build -a -o docker-collector-${KERNEL}-${MACHINE} docker-collector.go containersregistry.go

docker-collector:
	@godep go fmt ./...
	@godep go build -o docker-collector-${KERNEL}-${MACHINE} docker-collector.go containersregistry.go

clean:
	@godep go clean -i

docker-image: docker-collector
	@docker build -t cilium/docker-collector:latest .

update-godeps:
	@./scripts/update-godeps.sh

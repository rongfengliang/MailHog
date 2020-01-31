VERSION=1.0.0

all: fmt 

release:  release-deps 
	gox -ldflags "-X main.version=${VERSION}" -output="build/{{.Dir}}_{{.OS}}_{{.Arch}}" .

fmt:
	go fmt ./...

release-deps:
	go get github.com/mitchellh/gox

.PHONY: all  release fmt release-deps

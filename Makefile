SHELL=/usr/bin/env bash
GO_BUILD_IMAGE?=golang:1.19
NAME=delta-build
BRANCH=${BRANCH:-main}

.PHONY: all
all: delete build generate-swagger delete

.PHONY: build
build:
	git clone https://github.com/application-research/delta.git delta-build
	cd delta-build && git checkout $(BRANCH)
	cd delta-build && make all

.PHONE: clean
clean:
	rm -f delta
	git submodule deinit --all -f

install:
	install -C -m 0755 delta /usr/local/bin

.PHONY: generate-swagger
generate-swagger:
	scripts/swagger/swag.sh

.PHONY: delete
delete:
	rm -Rf delta-build
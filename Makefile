PKG_NAME:=github.com/chesapeaketechnology/mosquitto-exporter
BUILD_DIR:=bin
MOSQUITTO_EXPORTER_BINARY:=$(BUILD_DIR)/mosquitto_exporter
IMAGE := chesapeaketechnology/mosquitto-exporter
VERSION=0.1.0
LDFLAGS=-s -w -X main.Version=$(VERSION)
CGO_ENABLED=0
GOARCH=amd64
.PHONY: help
help:
	@echo
	@echo "Available targets:"
	@echo "  * build             - build the binary, output to $(ARC_BINARY)"
	@echo "  * linux             - build the binary, output to $(ARC_BINARY)"
	@echo "  * docker            - build docker image"

.PHONY: build
build:
	@mkdir -p $(BUILD_DIR)
	go build -tags netgo -a -v -o $(MOSQUITTO_EXPORTER_BINARY) -ldflags="$(LDFLAGS)" $(PKG_NAME)

linux: export GOOS=linux
linux: build

docker: linux
	docker build -t $(IMAGE):$(VERSION) .

push:
	docker push $(IMAGE):$(VERSION)

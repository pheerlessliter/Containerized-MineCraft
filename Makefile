# Append the git sha unless we are doing a release
ifdef IS_RELEASE
APP_VERSION := $(shell cat version.txt)
else
APP_VERSION ?= $(shell cat version.txt)-$(shell git rev-parse --short HEAD)
endif

REGISTRY:=aws.amazon.com
PNAME:=miaco

MINECRAFT_IMAGE_NAME:=${REGISTRY}/${PNAME}/minecraft
MINECRAFT_IMAGE:=${MINECRAFT_IMAGE_NAME}:${APP_VERSION}
MINECRAFT_IMAGE_LATEST:=${MINECRAFT_IMAGE_NAME}:latest

build:
	docker build -t ${MINECRAFT_IMAGE} minecraft
	docker tag ${MINECRAFT_IMAGE} ${MINECRAFT_IMAGE_LATEST}

destroy:
	MINECRAFT_IMAGE=${MINECRAFT_IMAGE} docker-compose -p ${PNAME} -f docker-compose.yml down -v

push: build
	docker push ${MINECRAFT_IMAGE}

# Only push latest if we are doing a release
ifdef IS_RELEASE
	docker push ${MINECRAFT_IMAGE_LATEST}
endif
	@echo "Pushed version ${APP_VERSION} to registry"

run:
	MINECRAFT_IMAGE=${MINECRAFT_IMAGE} docker-compose -p ${PNAME} -f docker-compose.yml up -d

stop:
	MINECRAFT_IMAGE=${MINECRAFT_IMAGE} -p ${PNAME} -f docker-compose.yml stop 

clean:
	-@docker rmi $$(docker images | grep ${PNAME}| awk '{ print $$3 }')

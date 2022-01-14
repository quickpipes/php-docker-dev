APP_NAME="php-docker-dev"
TAG_NAME="pauulog/php-docker-dev"
############
# Docker
#

list:
	@grep "^[^#[:space:]].*:" Makefile

docker-build:
	@echo "Building $(APP_NAME)"
	docker build -t $(APP_NAME) .

docker-tag-latest:
	@echo "Tagging $(APP_NAME) as $(TAG_NAME):latest"
	docker tag $(APP_NAME) $(TAG_NAME):latest

docker-push:
	@echo "Pushing $(APP_NAME) to $(TAG_NAME)"
	docker push $(TAG_NAME)

docker-release:
	docker buildx build --platform linux/amd64,linux/arm64 -t $(TAG_NAME):latest --push .

docker-make-builder:
	docker buildx create --name $(APP_NAME) --use
	docker buildx inspect --bootstrap

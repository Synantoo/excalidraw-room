all:
	@docker build --pull -t excalidrawroom .
	@trivy image excalidrawroom:latest

push:
	@test -z "$(VERSION)" && echo "Usage: VERSION=x.y.z make push" && exit 1 || true
	@docker login $(CONTAINER_REGISTRY_ENDPOINT) -u nologin -p $(SCW_SECRET_KEY)
	@docker tag excalidrawroom:latest $(CONTAINER_REGISTRY_ENDPOINT)/excalidrawroom:$(VERSION)
	@docker push $(CONTAINER_REGISTRY_ENDPOINT)/excalidrawroom:$(VERSION)
	@docker rmi $(CONTAINER_REGISTRY_ENDPOINT)/excalidrawroom:$(VERSION)

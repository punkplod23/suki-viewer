# Variables
IMAGE_NAME = suki-viewer
GHCR_URL = ghcr.io
USER = 
TAG = latest
FULL_NAME = $(GHCR_URL)/$(USER)/$(IMAGE_NAME):$(TAG)

.PHONY: build run login push deploy clean

# Build the tiny BusyBox image
build:
	docker build -t $(IMAGE_NAME) .

# Run locally for testing
run:
	docker run -p 8080:8080 --name $(IMAGE_NAME)-test --rm $(IMAGE_NAME)

# Log into GitHub Container Registry
# You will need a Personal Access Token (PAT) with 'write:packages' scope
login:
	echo $${CR_PAT} | docker login $(GHCR_URL) -u $(USER) --password-stdin

# Tag and Push to GHCR
push:
	docker tag $(IMAGE_NAME) $(FULL_NAME)
	docker push $(FULL_NAME)

# One command to do everything
deploy: build login push

# Stop and remove local containers/images
clean:
	docker stop $(IMAGE_NAME)-test || true
	docker rm $(IMAGE_NAME)-test || true
	docker rmi $(IMAGE_NAME) || true
SSH_SOCK ?= $(shell echo $$SSH_AUTH_SOCK)

help:
	@echo "Wisconsin Robotics Workspace Management:"
	@echo "  make setup        - Import child repos using vcstool"
	@echo "  make build        - Build all 3 Docker images (main, sim, gui)"
	@echo "  make up           - Start all containers in detached mode (for VS Code)"
	@echo "  make down         - Stop and remove all running containers"
	@echo "  make main         - Build, run, and attach to interactive main container"
	@echo "  make sim          - Build, run, and attach to interactive sim container"
	@echo "  make gui          - Build, run, and attach to interactive gui container"
	@echo "  make shell-main   - Attach interactive bash session to running main container"
	@echo "  make shell-sim    - Attach interactive bash session to running sim container"
	@echo "  make shell-gui    - Attach interactive bash session to running gui container"
	@echo "  make clean        - Stop containers and remove build cache"

setup:
	@mkdir -p workspace
	vcs import workspace < workspace.repos

build:
	SSH_AUTH_SOCK=$(SSH_SOCK) docker compose build

up:
	SSH_AUTH_SOCK=$(SSH_SOCK) docker compose up -d

down:
	docker compose down

main:
	SSH_AUTH_SOCK=$(SSH_SOCK) docker compose run --rm main bash

sim:
	SSH_AUTH_SOCK=$(SSH_SOCK) docker compose run --rm sim bash

gui:
	SSH_AUTH_SOCK=$(SSH_SOCK) docker compose run --rm gui bash

shell-main:
	docker exec -it wrover_main bash

shell-sim:
	docker exec -it wrover_sim bash

shell-gui:
	docker exec -it wrover_gui bash

clean:
	docker compose down --volumes --remove-orphans
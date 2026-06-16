run:
	docker run -it \
	--rm \
	--name wrover-container \
	--net=host \
	--privileged \
	-v $(shell cd .. && pwd):/root \
	-v $(HOME)/.gitconfig:/root/.gitconfig \
	-v $(SSH_AUTH_SOCK):/ssh-agent \
	-e SSH_AUTH_SOCK=/ssh-agent \
	wrover

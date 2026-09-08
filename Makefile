SSH_SOCK := $(if $(filter Darwin,$(shell uname -s)),/run/host-services/ssh-auth.sock,$(SSH_AUTH_SOCK))
run:
	docker run -it \
	--rm \
	--name wrover-container \
	--net=host \
	--privileged \
	-v $(shell cd .. && pwd):/root/workspace \
	-v $(HOME)/.gitconfig:/root/.gitconfig \
	-v $(SSH_SOCK):/ssh-agent \
	-e SSH_AUTH_SOCK=/ssh-agent \
	wrover

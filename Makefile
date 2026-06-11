run:
	docker run -it \
	--rm \
	--net=host \
	--privileged \
	-v $(shell cd ../WRoverSoftware_26-27 && pwd):/root/WRoverSoftware_26-27 \
	-v $(HOME)/.gitconfig:/root/.gitconfig \
	-v $(SSH_AUTH_SOCK):/ssh-agent \
	-e SSH_AUTH_SOCK=/ssh-agent \
	wrover

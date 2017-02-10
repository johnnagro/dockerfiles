#!/usr/bin/zsh

#
# Helper Functions
#
dcleanup(){
	docker rm $(docker ps -aq 2>/dev/null) 2>/dev/null
	docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
	docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}

del_stopped(){
	local name=$1
	local state=$(docker inspect --format "{{.State.Running}}" $name 2>/dev/null)

	if [[ "$state" == "false" ]]; then
		docker rm $name
	fi
}

relies_on(){
	local containers=$@

	for container in $containers; do
		local state=$(docker inspect --format "{{.State.Running}}" $container 2>/dev/null)

		if [[ "$state" == "false" ]] || [[ "$state" == "" ]]; then
			echo "$container is not running, starting it for you."
			$container
		fi
	done
}

vpn(){
	docker run -it \
	  --cap-add=NET_ADMIN \
	  --device /dev/net/tun \
	  --dns 8.8.8.8 \
	  --dns 8.8.4.4 \
	  -v $HOME/ownCloud/docker_data/vpn:/vpn \
	  --restart=always \
	  --name vpn \
	  -d dperson/openvpn-client -d -f
}

heroku(){
	docker run -it --rm -u $(id -u):$(id -g) \
		-v /etc/passwd:/etc/passwd:ro \
		-v /etc/group:/etc/group:ro \
		-v /etc/localtime:/etc/localtime:ro \
		-v /home:/home \
	  -v "$PWD":"$PWD" \
	  -w "$PWD" \
		-v /run/user/$(id -u):/run/user/$(id -u) \
    johnnagro/heroku-toolbelt "$@"
}

letsencrypt(){
	docker run -it --rm  \
	  -v /etc/localtime:/etc/localtime:ro \
	  -v /home/jnagro/ownCloud/env/letsencrypt:/etc/letsencrypt \
	  johnnagro/letsencrypt "$@"
}

1password(){
	# del_stopped 1password

	docker run \
	-v /etc/localtime:/etc/localtime:ro \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v $HOME/Dropbox:/root/Dropbox \
	-e DISPLAY=unix$DISPLAY \
	--name 1password \
	johnnagro/1password
}

torproxy(){
	del_stopped torproxy

	docker run -d \
		--restart always \
		-v /etc/localtime:/etc/localtime:ro \
		-p 9050:9050 \
		--name torproxy \
		jess/tor-proxy
}

thunderbird(){
  del_stopped thunderbird
	relies_on torproxy

  docker run --rm  -u $(id -u):$(id -g) -w $HOME \
    --device /dev/snd \
    --device /dev/dri \
		--net container:torproxy \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/group:/etc/group:ro \
    -v /etc/localtime:/etc/localtime:ro \
		-v /etc/machine-id:/etc/machine-id:ro \
    -v /home:/home \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /run/user/$(id -u):/run/user/$(id -u) \
    -e DISPLAY=unix$DISPLAY \
    --name thunderbird \
    johnnagro/thunderbird
}

atom(){
  # del_stopped atom
  docker run -u $(id -u):$(id -g) -w $HOME \
    --device /dev/snd \
    --device /dev/dri \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/group:/etc/group:ro \
    -v /etc/localtime:/etc/localtime:ro \
    -v /home:/home \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /run/user/$(id -u):/run/user/$(id -u) \
    -e DISPLAY=unix$DISPLAY \
    --name atom \
    johnnagro/atom "$@"
}

slack(){
  del_stopped slack

  docker run --rm  -u $(id -u):$(id -g) -w $HOME \
    --device /dev/dri \
		--device /dev/snd \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/group:/etc/group:ro \
		-v /etc/machine-id:/etc/machine-id:ro \
    -v /etc/localtime:/etc/localtime:ro \
    -v /home:/home \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /run/user/$(id -u):/run/user/$(id -u) \
    -e DISPLAY=unix$DISPLAY \
    --name slack \
    58bc7d634701
}

scudcloud(){
  # del_stopped scudcloud

  docker run -u $(id -u):$(id -g) -w $HOME \
    --device /dev/dri \
		--device /dev/snd \
    -v /etc/passwd:/etc/passwd:ro \
    -v /etc/group:/etc/group:ro \
		-v /etc/machine-id:/etc/machine-id:ro \
    -v /etc/localtime:/etc/localtime:ro \
    -v /home:/home \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -v /run/user/$(id -u):/run/user/$(id -u) \
    -e DISPLAY=unix$DISPLAY \
    --name scudcloud \
    johnnagro/scudcloud
}

# torbrowser(){
#   del_stopped torbrowser
#
#   docker run --rm \
#     --device /dev/snd \
#     --device /dev/dri \
#     -v /tmp/.X11-unix:/tmp/.X11-unix \
#     -e DISPLAY=unix$DISPLAY \
#     --name torbrowser \
#     jess/tor-browser
# }

torbrowser () {
	del_stopped torbrowser
	docker run --rm \
		--device /dev/snd \
		--device /dev/dri \
		-v /tmp/.X11-unix:/tmp/.X11-unix \
		-e DISPLAY=unix$DISPLAY \
		--name torbrowser \
		johnnagro/torbrowser
}

# sudo podman run -d --name=gogs-docker -p 10022:22 -p 10050:3000 -v ~/Documents/gogs:/data gogs/gogs
if [ ! "$(docker ps -q -f name=gogs)" ]; then
    if [ "$(docker ps -aq -f status=exited -f name=gogs)" ]; then
        # cleanup
        docker rm gogs
    fi
    docker run -d --name=gogs -p 10022:22 -p 10050:3000 -v /home/karthick/Documents/gogs:/data gogs/gogs
fi

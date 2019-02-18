# minecraft
# Running Locally
Requirements:
 - Docker Engine: 1.13.0+
 - Docker-Compose: 1.10.0+
 - Make: Most/Any version

How to run:
 1. Setup your environment by changing variables in the server.env file
 2. Change (or leave) the port that you'll be using in the docker-compose.yml file. This must match server.env
 3. Change to the project base directory, if you aren't already in it
 4. run `make build` This will download the openjdk container and put your files in place
 5. run `make run` This will start your server in detached mode

How to stop:
 - `make stop` will stop the container, but leave the volumes in place
 - `make destroy` will stop the container and DESTROY the volumes. Be careful you don't have important data.

How to send commands:
 1. Attach to your container with `docker attach <container name or id>` This is possible because of stdin and tty in docker-compose
 2. Run whatever minecraft servers you need (e.g. `save-all` `msg` etc) Be careful with a stop command, because it stops the container
 3. Exit the command interface with an escape character. By default this is `ctrl + p then q while still holding ctrl`

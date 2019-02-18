# Containerized MineCraft (CoMiC)
Disclaimer: This is a pet-project, and I am not responsible for any lost data. Use this at your own risk and make
regular backups of your volumes/files that you care about. Changes to the MineCraft code could make this obsolete,
and I have a full time job that isn't keeping up on MineCraft releases (unfortunately).

Also, if you use the code here on your own projects, some credit is always appreciated!

Test it, beat it up, improve it, and contribute back! Projects like these are normal for me, and I do similar things for work, so let me know if you want to see other containerized projects. I may consider it.

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
 - You can watch the status of your container's build process by utilizing `docker logs --follow <container name or id>`

How to stop:
 - `make stop` will stop the container, but leave the volumes in place
 - `make destroy` will stop the container and DESTROY the volumes. Be careful you don't have important data

How to send commands:
 1. Attach to your container with `docker attach <container name or id>` This is possible because of stdin and tty in docker-compose
 2. Run whatever minecraft servers you need (e.g. `save-all` `msg` etc) Be careful with a stop command, because it stops the container
 3. Exit the command interface with an escape character. By default this is `ctrl + p then q while still holding ctrl`

How to import an existing World file:
 1. Compress a World directory (including the base world/ directory, not just the contents of it)
 2. Upload a backup of your world directory, zipped into .tar.gz (currently) to someplace publicly accessible. (transfer.sh is great)
 2. Get the link to your file, and paste it in the server.env file in the WORLD_FILE variable. No quotation marks
 3. Start your server. This will only work on a fresh install, as doing this on an existing directory causes data loss

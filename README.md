# Containerized MineCraft (CoMiC)
Disclaimer: This is a pet-project, and I am not responsible for any lost data. Use this at your own risk and make
regular backups of your volumes/files that you care about. Changes to the MineCraft code could make this obsolete,
and I have a full time job that isn't keeping up on MineCraft releases (unfortunately).

Also, if you use the code here on your own projects, some credit is always appreciated!

Test it, beat it up, improve it, and contribute back! Projects like these are normal for me, and I do similar things for work, so let me know if you want to see other containerized projects. I may consider it.

# Running Locally (Yay, LAN parties!)
Software Requirements:
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

# Running in ECS (Yay, long-distant friendship!)
Software Requirements:
 - Docker Engine: 1.13.0+
 - Docker-Compose: 1.10.0+
 - Make: Most/Any version
 - AWS-CLI (https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)

Environment Requirements:
 - An AWS account with activated ECS and Repository (free, if unused, and no I won't pay your bills for trying this.)
 - You've setup your AWS credentials by running `aws configure` on your local machine
 - You've logged into the AWS endpoint for your region (e.g. `$(aws ecr get-login --no-include-email --region us-west-2)`)

Build and upload your versioned container:
 1. Setup your environment by changing variables in the server.env file
 2. Change the REGISTRY variable in the Makefile to match your base repository address you get from AWS ECS
 3. Change (or leave) the port that you'll be using in the docker-compose.yml file. This must match server.env
 4. Change to the project base directory, if you aren't already in it
 5. run `make build` This will download the openjdk container and put your files in place
 - It's recommended that you do a `make run` to test and make sure your build works fine.
 6. run a `make push` to build, release, and push your container to AWS. You can skip step 5 if you're super confident.

Add your container to ECS (AKA the long section):
 1. Log into your ECS control panel on AWS
 2. Click "Task Definitions", "Create Task Definition" then "Fargate" (We'll do this for clustering instead of our own ECS instances)
 3. I usually fill out the top two sections with these (Yours may vary a little):
 - Task Definition Name: CoMiC
 - Requires Compatibilities: FARGATE
 - Task Role: ecsTaskExecutionRole
 - Network Mode: awsvpc
 - Task execution role: ecsTaskExecutionRole
 4. Fill out your Task Memory and Task CPU. This should be equal to or more than you give minecraft in your configs.
 5. Skip to the bottom and add your Volume. Mine matches the docker-compose with "minecraft_data"
 6. Click "Add Container" and prepare to fill out a lot of information. The docker-compose, env file will give you all you need. Adjust as needed:
 - Container name: minecraft
 - Image: The location where you uploaded your docker image. This example uses the AWS Repository. I won't link that in a public repo...
 - Private repository authentication: You may need this if you upload to a private docker image repository
 - Port mappings: Must match your minecraft server.properties. Mine is 2300/TCP in the example.
 - Command: Blank (optional)
 - Interval: Blank (optional)
 - Timeout: Blank (optional)
 - Start period: Blank (optional)
 - Retries: Blank (optional)
 - CPU units: 
 - GPUs: 
 - Essential: Checked
 - Entry point: Blank
 - Command: Blank (It's in the Dockerfile and can be moved out if wanted)
 - Working Directory: Blank (It's in the start.sh file and can be moved out if wanted)
 - Environment Variables: Hate to say it, but copy each one from the server.env file. Yikes.
 - Disable networking: Unchecked
 - Links: Blank
 - Hostname: Blank (Optional)
 - DNS servers: 8.8.8.8 and 8.8.4.4 (line separated)
 - DNS search domains: Blank
 - Extra hosts: Blank
 - Read only root file system: Unchecked
 - Mount points: Source volume = minecraft_data , Container path = /var/lib/minecraft , Read only = Unchecked
 - Volumes from: Blank
 - Log configuration: Checked (optional)
 - Ulimits: Blank
 - Key value pairs: Blank
 7. Click Update/Save on the bottom
 8. Click Create on the bottom.
 9. In the ECS main menu, click "Clusters" on the top left.
 10. Click "Create Cluster" then "Networking only"
 11. Name your cluster. Mine is "CoMiC-Smiley". The rest of the values are usually fine to leave on default.
 12. Now, back in the main menu again... Click "Clusters" on the top left, then the name of the one you just made.
 13. Click the "Service" tab then "Create Service"
 14. Here's some more values! YAY!
 - Launch Type: FARGATE
 - Task Definition: This is the one you just made, it'll be in the dropdown. Mine is CoMiC.
 - Revision: latest is usually fine, unless you have to revert to an old version
 - Platform version: LATEST
 - Cluster: The one you just made. Mine is "CoMiC-Smiley"
 - Service name: Name it something good, like CoMiC-Smiley-Svc
 - Service type: Defaults to REPLICA and can't be changed
 - Number of tasks: 1 (This is how many servers you want to run, but you'll have to figure out port info if you do more)
 - Minimum healthy percent: 100
 - Maximum percent: 200 (This allows you to do an upgrade where you spin one up and it kills the old one when it's healthy)
 - Deployment type: Rolling update
 15. Click next. See more values. Fill out more values...
 - Cluster VPC: Pick one from your list for the IP range you want to use
 - Subnets: Click all subnets you don't mind your instance using for networking
 - Security Group: Use an existing one or setup a new one with the port included that you set in your server.properties file
 - Auto-assign public IP: Enabled
 - Skip the Health check and Load Balancing sections, unless you plan to use them
 - Service discovery options: Unchecked. All are optional, but they are super useful if you want to use DNS to connect to your server. Research it!
 16. Click next. Ignore the next section, as we aren't auto-scaling. Just click next again.
 17. Review your information. Make sure it all looks good. Click "Create Service" at the bottom.
 18. Go back to your Cluster, click tasks, and you can watch the status, look at logs, etc. If all goes well, in about 10-20 minutes you'll have a running Minecraft server.
 19. The last step. I swear. Using the IP you have on the container, connect to the Minecraft server with your client. EZPZ, right? 

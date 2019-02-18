#!/bin/bash
set -x

# Reducing repeated information and allow docker-compose to manipulate endpoints
#minecraft_manifest=https://launchermeta.mojang.com/mc/game/version_manifest.json
#install_directory=/etc/minecraft
minecraft_manifest=$MINECRAFT_MANIFEST
install_directory=$INSTALL_DIRECTORY

# Subject to change, but this is where they currently track the file versions and locations
latest_version=$(curl -s $minecraft_manifest | jq --raw-output .latest.release)
latest_url=$(curl -s $minecraft_manifest | jq --raw-output ".versions[] | select(.id == \"$latest_version\") | .url")
latest_server_url=$(curl -s $latest_url | jq --raw-output .downloads.server.url)

# The command used to start minecraft
java_command="java $JAVA_COMMAND_ARGS -jar minecraft_server.$latest_version.jar nogui"

pushd $install_directory

# Regardless of version, if the latest isn't available, download it.
if [ ! -f minecraft_server.$latest_version.jar ]
then
    rm -rf minecraft_server.*
    wget $latest_server_url -O minecraft_server.$latest_version.jar
fi

# If the eula file exists or not, lets go ahead and set it to accepted.
# You are still required to read the EULA before running the server, so using this is an agreement that you have and do accept it.
echo "eula=true" > eula.txt

# We are going to re-write the properties file every time. This fixes bad deploys and allows for setting updates.
# Running this companion file is cleaner than filling this run script with ~40 sed commands
cp server.tmpl server.properties
/bin/sh setup.sh

# This will check for the world directory, if it exists skip entirely. Don't risk data loss
if [ ! -d $LEVEL_NAME ]
then
    echo "$LEVEL_NAME directory is not empty. Importing a new world file will not continue"
else
    # Check if you have set the variable for a World backup to download and unpack.
    if [ -z "$WORLD_FILE" ]
    then
        echo "$LEVEL_NAME backup file does not exist in the WORLD_FILE variable. Making new world."
    else
        wget $WORLD_FILE -O world.tar.gz
        tar xzvf world.tar.gz
        rm -rf world.tar.gz
    fi
fi

exec $java_command

#!/bin/bash
set -x

sed -i "s/view-distance=10/view-distance=$VIEW_DISTANCE/" server.properties
sed -i "s/max-build-height=256/max-build-height=$MAX_BUILD_HEIGHT/" server.properties
sed -i "s/server-ip=/server-ip=$SERVER_IP/" server.properties
sed -i "s/level-seed=/level-seed=$LEVEL_SEED/" server.properties
sed -i "s/gamemode=0/gamemode=$GAMEMODE/" server.properties
sed -i "s/server-port=25565/server-port=$SERVER_PORT/" server.properties
sed -i "s/enable-command-block=false/enable-command-block=$ENABLE_COMMAND_BLOCK/" server.properties
sed -i "s/allow-nether=true/allow-nether=$ALLOW_NETHER/" server.properties
sed -i "s/enable-rcon=false/enable-rcon=$ENABLE_RCON/" server.properties
sed -i "s/op-permission-level=4/op-permission-level=$OP_PERMISSION_LEVEL/" server.properties
sed -i "s/enable-query=false/enable-query=$ENABLE_QUERY/" server.properties
sed -i "s/prevent-proxy-connections=false/prevent-proxy-connections=$PREVENT_PROXY_CONNECTIONS/" server.properties
sed -i "s/generator-settings=/generator-settings=$GENERATOR_SETTINGS/" server.properties
sed -i "s/resource-pack=/resource-pack=$RESOURCE_PACK/" server.properties
sed -i "s/player-idle-timeout=0/player-idle-timeout=$PLAYER_IDLE_TIMEOUT/" server.properties
sed -i "s/level-name=world/level-name=$LEVEL_NAME/" server.properties
sed -i "s/motd=A Minecraft Server/motd=$MOTD/" server.properties
sed -i "s/force-gamemode=false/force-gamemode=$FORCE_GAMEMODE/" server.properties
sed -i "s/hardcore=false/hardcore=$HARDCORE/" server.properties
sed -i "s/white-list=false/white-list=$WHITE_LIST/" server.properties
sed -i "s/broadcast-console-to-ops=true/broadcast-console-to-ops=$BROADCAST_CONSOLE_TO_OPS/" server.properties
sed -i "s/pvp=true/pvp=$PVP/" server.properties
sed -i "s/spawn-npcs=true/spawn-npcs=$SPAWN_NPCS/" server.properties
sed -i "s/generate-structures=true/generate-structures=$GENERATE_STRUCTURES/" server.properties
sed -i "s/spawn-animals=true/spawn-animals=$SPAWN_ANIMALS/" server.properties
sed -i "s/snooper-enabled=true/snooper-enabled=$SNOOPER_ENABLED/" server.properties
sed -i "s/difficulty=1/difficulty=$DIFFICULTY/" server.properties
sed -i "s/network-compression-threshold=256/network-compression-threshold=$NETWORK_COMPRESSION_THRESHOLD/" server.properties
sed -i "s/level-type=DEFAULT/level-type=$LEVEL_TYPE/" server.properties
sed -i "s/spawn-monsters=true/spawn-monsters=$SPAWN_MONSTERS/" server.properties
sed -i "s/max-tick-time=60000/max-tick-time=$MAX_TICK_TIME/" server.properties
sed -i "s/enforce-whitelist=false/enforce-whitelist=$ENFORCE_WHITELIST/" server.properties
sed -i "s/use-native-transport=true/use-native-transport=$USE_NATIVE_TRANSPORT/" server.properties
sed -i "s/max-players=20/max-players=$MAX_PLAYERS/" server.properties
sed -i "s/resource-pack-sha1=/resource-pack-sha1=$RESOURCE_PACK_SHA1/" server.properties
sed -i "s/online-mode=true/online-mode=$ONLINE_MODE/" server.properties
sed -i "s/allow-flight=false/allow-flight=$ALLOW_FLIGHT/" server.properties
sed -i "s/max-world-size=29999984/max-world-size=$MAX_WORLD_SIZE/" server.properties

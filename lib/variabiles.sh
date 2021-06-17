#!/usr/bin/env bash

export EDITOR="$(which nano)"

#export PATH=$HOME/.local/bin:$HOME/.rbenv/bin:$HOME/bin:$HOME/.gem/ruby/1.8/bin:/usr/local/git/bin:/Applications/Emacs.app/Contents/MacOS/bin:/usr/share/source-highlight:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/git/bin:/Applications/Postgres.app/Contents/Versions/9.4/bin:/usr/games/:/usr/lib/go-1.6/bin
export INFOPATH=$INFOPATH:/usr/share/info

if [ -d /opt/pg.zone ]; then
    export PG_ZONE=/opt/pg.zone
    export PG_ZONE_APPS=${PG_ZONE}/apps
    export PG_ZONE_LOG=${PG_ZONE}/logs
    export PG_ZONE_DB=${PG_ZONE}/dbs
    export PG_ZONE_DB_DATA=${PG_ZONE}/data
fi

# EXPORT GO LANG PATH
if [ -d ${PG_ZONE}/go ]; then
    export GOROOT=${PG_ZONE}/go1.9
    export PATH=$PATH:${GOROOT}/bin
fi

# EXPORT MONGODB
if [ -d ${PG_ZONE_DB}/mongodb ]; then
    export MONGODB_PATH_BIN=${PG_ZONE_DB}/mongodb/bin
    export MONGO_PATH_DATA=${PG_ZONE_DB_DATA}/mongodb_data
    export MONGO_PATH_LOG=${PG_ZONE_LOG}/mongodb
    export PATH=$PATH:${MONGODB_PATH_BIN}
fi

# EXPORT NODEJS TO PATH
if [ -d ${PG_ZONE}/langs/nodejs ]; then
    export PATH=$PATH:${PG_ZONE}/langs/nodejs
fi



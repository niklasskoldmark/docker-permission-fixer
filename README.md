# docker-permission-fixer

## Description

Sometimes when running container share mounted volumes thera are permission problems because the files are owned by different UIDs in different containers.

This container is a quickfix to watch paths for permision changes and try to fix them by setting 777 permissions on all files
## Sample `docker run`
```
docker run \
    -d \
    --name=permission-fixer \
    -e PERMISSION=776 \
    -e LOG_ALL_TO_CONSOLE=true \
    -v /etc/dockercontainers/nginx:/watchdir/nginixconfig \
    niklasskoldmark/permission-fixer
```

## Configuration

### Set one or many volumes to watch by munting them in /watchdir/

```-v /first/directory/to/watch":/watchdir/mountname```

```-v /second/directory/to/watch":/watchdir/anothermountname```

Everything has to be mounted in the root of /watchdir/ you can not make a long path beneath it

(it will watch and fix the mounts recursively though)

### Set the permission to be enforced

```-e PERMISSION=[any chmod permission (777 is default)]```

### Set logging parameters
By default it will log to the console of the container for easy acces via : `docker logs [containername]`

```-e LOG_ERROR_TO_CONSOLE=[true(default)|false]```

```-e LOG_ALL_TO_CONSOLE=[true|false(default)]```

#### You can also log to a file if you want

```-e LOG_ERROR_TO_FILE=[true|false(default)]```

```-e LOG_ALL_TO_FILE=[true|false(default)]```

#### The files can be mounted

```-v "/my/permissionfix.log":/logdir/permissionfix.log```

```-v "/my/permissionfixerror.log":/logdir/permissionfixerror.log```

#### Or you can mount the logdirectory to get both logs

```-v /my/logdirectory":/logdir```

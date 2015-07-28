#!/bin/sh
# Initially change permissions for all in watchdir
chmod -R "$PERMISSION" /watchdir/
#################################################################
# Watch directories for changes (exclude hidden directories), reload apache2 if changed
while : ; do
    inotifywait \
    --recursive \
    --timefmt '%d/%m/%y/%H:%M' \
    --format '%T %w %f' \
    --event attrib \
    --event create \
    --event modify \
    --event move \
    --exclude '/\..+' \
    /watchdir/ \
    | while read time directory file; do
        if chmod -R "$PERMISSION" ${dir}${file}
        then
            [ "$LOG_ALL_TO_FILE" = true ] && \
                echo "${time} fixed permissions, change in ${dir}${file}" >> /logdir/permissionfix.log

            [ "$LOG_ALL_TO_CONSOLE" = true ] && \
                echo "${time} fixed permissions, change in ${dir}${file}"
        else
             
            [ "$LOG_ALL_TO_FILE" = true ] || [ "$LOG_ERROR_TO_FILE" = true ] && \
                echo "${time} couldnt fix permissions, change in ${dir}${file}" >> /srv/permissionfixerror.log

            [ "$LOG_ALL_TO_CONSOLE" = true ] || [ "$LOG_ERROR_TO_CONSOLE" = true ] && \
                echo "${time} couldnt fix permissions, change in ${dir}${file}"
        fi
    done
done
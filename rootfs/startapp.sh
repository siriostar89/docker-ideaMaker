#!/usr/bin/with-contenv sh

set -u # Treat unset variables as an error.
export HOME=/config

trap "exit" TERM QUIT INT
trap "kill_im" EXIT

log() {
    echo "[imsupervisor] $*"
}

getpid_im() {
    PID=UNSET
    if [ "$PID" = "UNSET" ]; then
        PID="$(ps -o pid,args | grep -w "ideamaker" | grep -vw grep | tr -s ' ' | cut -d' ' -f2)"
    fi
    echo "${PID:-UNSET}"
}

is_im_running() {
    [ "$(getpid_im)" != "UNSET" ]
}

start_im() {
    /usr/bin/ideamaker
}

kill_im() {
    PID="$(getpid_im)"
    if [ "$PID" != "UNSET" ]; then
        log "Terminating ideaMaker..."
        kill $PID
        wait $PID
    fi
}

if ! is_im_running; then
    log "ideaMaker not started yet.  Proceeding..."
    start_im
fi

IM_NOT_RUNNING=0
while [ "$IM_NOT_RUNNING" -lt 5 ]
do
    if is_im_running; then
        IM_NOT_RUNNING=0
    else
        IM_NOT_RUNNING="$(expr $IM_NOT_RUNNING + 1)"
    fi
    sleep 1
done

log "ideaMaker no longer running.  Exiting..."

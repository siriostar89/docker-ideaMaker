#!/bin/bash
until pids=$(pidof x11vnc)
do   
    sleep 1
done

/usr/bin/ideamaker

#!/bin/bash

declare -i hours=0
declare -i minutes=0
declare -i secs=0

declare -i timminutes=0
declare -i timsecs=0

declare -i pomodoro=0

timstop=0

while [[ $timstop -eq 0 ]]; do

    while [[ ($timminutes -ne 25) && ($timstop -eq 0) ]]; do
        read -t 1 -n 1 && timstop=1
        timsecs+=1
        secs+=1
        if [[ $timsecs -eq 60 ]]; then
            timminutes+=1
            timsecs=0
        fi
        if [[ $secs -eq 60 ]]; then
            minutes+=1
            secs=0
        fi
        if [[ $minutes -eq 60 ]]; then
            hours+=1
            minutes=0
        fi

        printf "\rtimer: %02d:%02d\r" $timminutes $timsecs
    done
    
    printf "\n"
    timminutes=0
    pomodoro+=1

    if [[ ($pomodoro -eq 4) && ($timstop -eq 0) ]]; then
        pomodoro=0
        while [[ ($timminutes -ne 30) && ($timstop -eq 0) ]]; do
            read -t 1 -n 1 && timstop=1
            timsecs+=1
            secs+=1
            if [[ $timsecs -eq 60 ]]; then
                timminutes+=1
                timsecs=0
            fi
            if [[ $secs -eq 60 ]]; then
                minutes+=1
                secs=0
            fi
            if [[ $minutes -eq 60 ]]; then
                hours+=1
                minutes=0
            fi

            printf "\rlong break: %02d:%02d\r" $timminutes $timsecs
        done
        printf "\n"
        timminutes=0
    else
        while [[ ($timminutes -ne 5) && ($timstop -eq 0) ]]; do
            read -t 1 -n 1 && timstop=1
            timsecs+=1
            secs+=1
            if [[ $timsecs -eq 60 ]]; then
                timminutes+=1
                timsecs=0
            fi
            if [[ $secs -eq 60 ]]; then
                minutes+=1
                secs=0
            fi
            if [[ $minutes -eq 60 ]]; then
                hours+=1
                minutes=0
            fi

            printf "\rbreak: %02d:%02d\r" $timminutes $timsecs
        done
        printf "\n"
        timminutes=0
    fi


done
printf "\ntotal elapsed: %02d:%02d:%02d\n" $hours $minutes $secs
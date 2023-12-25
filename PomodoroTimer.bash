#!/bin/bash

# variables
declare -i hours=0
declare -i minutes=0
declare -i secs=0

declare -i timminutes=0
declare -i timsecs=0

declare -i pomodoro=0

timstop=0

# functions
function timer()
{
    while [[ ($timminutes -ne $1) && ($timstop -eq 0) ]]; do
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

        printf "\r%s: %02d:%02d\r" $2 $timminutes $timsecs
    done
    printf "\n"
    timminutes=0
}

# program start
while [[ $timstop -eq 0 ]]; do

    timer 25 "timer"
    pomodoro+=1

    if [[ ($pomodoro -eq 4) && ($timstop -eq 0) ]]; then
        pomodoro=0
        timer 30 "long break"
    else
        timer 5 "break"
    fi


done
printf "\ntotal elapsed: %02d:%02d:%02d\n" $hours $minutes $secs
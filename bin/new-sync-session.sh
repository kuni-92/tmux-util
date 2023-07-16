#!/bin/bash

SCRIPT_NAME=$(basename $0)

if [ $# -lt 2 ]; then
	echo "usage: ${SCRIPT_NAME} [command] [targets...]"
	exit 1
fi

SESSION_NAME=mt-session
WINDOW_NAME=mt-window
COMMAND=$1

tmux new-session -d -n ${WINDOW_NAME} -s ${SESSION_NAME}

for p in ${@:2}
do
	tmux split-window -v -t ${WINDOW_NAME}
	tmux send-keys "${COMMAND} ${p}"
	tmux select-layout -t ${WINDOW_NAME} even-vertical
done

tmux kill-pane -t 0
tmux select-window -t ${WINDOW_NAME}
tmux select-pane -t 0
tmux select-layout -t ${WINDOW_NAME} even-vertical

tmux set-window-option synchronize-panes on
tmux attach-session -t ${SESSION_NAME}

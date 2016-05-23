tmux new-session -d -s 'my-tmux' -n 'home'
tmux new-window -n 'vim'
tmux split-window -h
tmux selectw -t 1
tmux selectp -t 0
tmux resize-pane -R 10
tmux -2 attach-session -d

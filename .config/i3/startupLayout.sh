cmd="workspace 1; "
cmd="${cmd}append_layout ~/.config/i3/workspace-1.json; "
cmd="${cmd}exec google-chrome-stable; "
cmd="${cmd}exec termite; exec termite;"
i3-msg ${cmd}

cmd="workspace 1; "
cmd="${cmd}append_layout ~/.config/i3/workspace-1.json; "
cmd="${cmd}exec opera; "
cmd="${cmd}exec termite; "
i3-msg ${cmd}

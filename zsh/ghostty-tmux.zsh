# Auto-attach to tmux in Ghostty
if [[ "$TERM_PROGRAM" == "ghostty" ]] && [[ -z "$TMUX" ]]; then
  exec tmux new-session -A -s main
fi

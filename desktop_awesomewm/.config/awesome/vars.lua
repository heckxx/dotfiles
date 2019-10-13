return {
  chosen_theme = "powerarrow-dark",
  lock         = "i3lock --blur=5" ..
  " --pass-media-keys --clock --timecolor=ffffffa0 --datecolor=ffffff60 " ..
  " --veriftext='hmmmm' --wrongtext='nope!' -n",
  modkey       = "Mod3",
  altkey       = "Mod1",
  terminal     = "termite" or "urxvt" or "xterm",
  editor       = os.getenv("EDITOR") or "vim" or "vi",
  gui_editor   = "gvim",
  browser      = "firefox",
  useless_gap  = 5
}

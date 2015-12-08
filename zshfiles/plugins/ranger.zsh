# vim: set ft=zsh

# ranger-cd
#------------------------------------------------------------------------------
# Compatible with ranger 1.4.2 through 1.7.*
#
# Automatically change the directory in bash after closing ranger
#
# This is a bash function for .bashrc to automatically change the directory to
# the last visited one after ranger quits.
# To undo the effect of this function, you can type "cd -" to return to the
# original directory.

function ranger-cd() {
  local tempfile="$(mktemp -t tmp.XXXXXXX)"
  # for manual install
  /usr/local/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
  # for package install
  # /usr/bin/ranger --choosedir="$tempfile" "${@:-$(pwd)}"
  test -f "$tempfile" &&
  if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
      cd -- "$(cat "$tempfile")"
  fi
  rm -f -- "$tempfile"
}

compdef ranger-cd=ranger


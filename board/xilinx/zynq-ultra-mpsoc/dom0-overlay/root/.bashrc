# If not running interactively, don't do anything
[ -v "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
# busybox resize
resize


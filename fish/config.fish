if status is-interactive
  # Commands to run in interactive sessions can go here

  alias rm='rm -i'
  alias cp='cp -i'
  alias mv='mv -i'
  alias la='ls -a'

  starship init fish | source
end

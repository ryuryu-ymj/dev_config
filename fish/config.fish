pyenv init - | source

if status is-interactive
  # Commands to run in interactive sessions can go here

  alias rm='rm -i'
  alias cp='cp -i'
  alias mv='mv -i'
  alias ls='eza --icons'
  alias la='eza -a --icons'
  alias lt='eza -T --icons'
  alias tp='trash -F'

  starship init fish | source

  if test -z $TMUX
    set count 0
    for ses in (tmux list-sessions | cut -d: -f1)
      if test $ses -eq $count
        set count (math $count + 1)
      else if test $ses -gt $count
        tmux rename-session -t $ses $count
        set count (math $count + 1)
      end
    end

    set ses (tmux list-sessions)
    if test -z $ses[1]
      exec tmux new-session
    else
      set new 'Create new session'
      set ses $ses $new
      set ses (printf '%s\n' $ses | fzf | cut -d: -f1)
      if test -n "$ses"
        if test $ses = $new
          exec tmux new-session -s $count
        else
          exec tmux attach-session -t $ses
        end
      end
    end
  end
end

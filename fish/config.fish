set -x LANG ja_JP.UTF-8
set -x EDITOR vim

# homebrew
set -x PATH /usr/local/bin /usr/local/sbin $PATH

# rbenv
source (rbenv init - | psub)
set -x PATH $HOME/.rbenv/shims $PATH
rbenv rehash >/dev/null ^&1

# nodebrew
set -x PATH $HOME/.nodebrew/current/bin $PATH

# alias
balias o open
balias g git
balias t tig
balias dot-visible 'defaults write com.apple.finder AppleShowAllFiles true;killall Finder'
balias dot-invisible 'defaults write com.apple.finder AppleShowAllFiles falese;killall Finder'

# key binding
function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'

  bind \cl forward-char
  bind \ch backward-char
  bind \cf forward-bigword
  bind \cb backward-bigword
end

# ll after cd
function cd
  if test (count $argv) -gt 1
    printf "%s\n" (_ "Too many args for cd command")
    return 1
  end
  # Avoid set completions.
  set -l previous $PWD

  if test "$argv" = "-"
    if test "$__fish_cd_direction" = "next"
      nextd
    else
      prevd
    end
    return $status
  end
 
  builtin cd $argv
  set -l cd_status $status

  # Log history
  if test $cd_status -eq 0 -a "$PWD" != "$previous"
    set -q dirprev[$MAX_DIR_HIST]
    and set -e dirprev[1]
    set -g dirprev $dirprev $previous
    set -e dirnext
    set -g __fish_cd_direction prev
  end

  if test $cd_status -ne 0
    return 1
  end

  ls
  return $status
end

# apply local conifg
source $HOME/.config/fish/config.local.fish > /dev/null 2>&1

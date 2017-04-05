function _pwd_with_tilde
  echo $PWD | sed 's|^'$HOME'\(.*\)$|~\1|'
end

function _in_git_directory
  git rev-parse --git-dir > /dev/null 2>&1
end

function _set_git_prompt
  set -g __fish_git_prompt_color 6C6C6C

  set -g __fish_git_prompt_showdirtystate true
  set -g __fish_git_prompt_char_stateseparator ''

  set -g __fish_git_prompt_showupstream name
  set -g __fish_git_prompt_color_upstream cyan
  set -g __fish_git_prompt_char_upstream_prefix ''
  set -g __fish_git_prompt_char_upstream_equal ''
  set -g __fish_git_prompt_char_upstream_ahead ' ⇡'
  set -g __fish_git_prompt_char_upstream_behind ' ⇣'
  set -g __fish_git_prompt_char_upstream_diverged ' ⇡⇣'
end

function _ssh_hostname
  echo $USER"@"(hostname | cut -d . -f1)
end

function _cmd_duration_days
  set -l days (expr $CMD_DURATION / 1000 / 60 / 60 / 24)
  if test $days -gt 0
    echo $days"d "
  end
end

function _cmd_duration_hours
  set -l hours (expr $CMD_DURATION / 1000 / 60 / 60 \% 24)
  if test $hours -gt 0
    echo $hours"h "
  end
end

function _cmd_duration_mins
  set -l minutes (expr $CMD_DURATION / 1000 / 60 \% 60)
  if test $minutes -gt 0
    echo $minutes"m "
  end
end

function _cmd_duration_secs
  set -l seconds (expr $CMD_DURATION / 1000 \% 60)
  if test $seconds -gt 0
    echo $seconds"s"
  end
end

function _cmd_duration
  set -l duration ""

  set duration "$duration"(_cmd_duration_days)
  set duration "$duration"(_cmd_duration_hours)
  set duration "$duration"(_cmd_duration_mins)
  set duration "$duration"(_cmd_duration_secs)

  echo $duration
end

function _visual_prompt_len
  set -l prompt_info $argv[1]
  set prompt_info (string replace -ra -- '\x1b.*?[mGKH]' '' $prompt_info)
  set -l prompt_info_len (string length $prompt_info)
  echo $prompt_info_len
end

function _print_in_color
  set -l string $argv[1]
  set -l color  $argv[2]

  set_color $color
  printf $string
  set_color normal
end

function _prompt_color_for_status
  if test $argv[1] -eq 0
    echo magenta
  else
    echo red
  end
end

function fish_prompt
  set -l pwd_piece (_pwd_with_tilde)
 
  set -l git_piece ""
  if _in_git_directory
    _set_git_prompt
    set git_piece (__fish_git_prompt)
  end

  set -l ssh_piece ""
  if set -q SSH_CONNECTION
    set ssh_piece " "(_ssh_hostname)
  end

  set -l dur_piece ""
  if test $CMD_DURATION -gt 5000
    set dur_piece " "(_cmd_duration)
  end

  set -l info_line "$pwd_piece$git_piece$ssh_piece$dur_piece"
  set -l prompt_len (_visual_prompt_len $info_line)
  if test $prompt_len -gt $COLUMNS
    set pwd_piece (prompt_pwd)
  end

  _print_in_color "\n$pwd_piece" blue
  printf $git_piece
  _print_in_color $ssh_piece 6C6C6C
  _print_in_color $dur_piece yellow

  set -l last_status $status
  _print_in_color "\n❯ " (_prompt_color_for_status $last_status)
end

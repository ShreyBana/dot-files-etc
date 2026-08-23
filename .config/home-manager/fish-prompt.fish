set -l last_status $status

# --- Path ---
set -l cwd (string replace -r "^$HOME" '~' $PWD)
set -l parts (string split '/' $cwd)
set -l n (count $parts)
set -l result

for i in (seq 1 $n)
  if test $i -eq $n
    set result $result $parts[$i]
  else
    set result $result (string sub -l 1 $parts[$i])
  end
end

set -l path_display (string join '/' $result)

# --- Git ---
set -l git_part ""
if command git rev-parse --git-dir >/dev/null 2>&1
  set -l branch (command git symbolic-ref --short HEAD 2>/dev/null \
                 || command git rev-parse --short HEAD 2>/dev/null)

  # Rebase detection
  set -l git_dir (command git rev-parse --git-dir 2>/dev/null)
  set -l rebase_label ""
  if test -d "$git_dir/rebase-merge" -o -d "$git_dir/rebase-apply"
    set rebase_label " RE_BASING"
  end

  # Dirty (unstaged changes or untracked)
  set -l dirty ""
  if not command git diff --quiet 2>/dev/null
    set dirty "*"
  end

  # Staged
  set -l staged ""
  if not command git diff --cached --quiet 2>/dev/null
    set staged "✚"
  end

  set git_part " git:$branch$dirty$staged$rebase_label"
end

# --- Render ---
set_color --bold cyan;   echo -n "[$path_display]"
set_color yellow; echo -n "$git_part"
set_color normal; echo

if test $last_status -ne 0
    set_color --bold red
else
    set_color --bold green
end
echo -n '> '
set_color normal

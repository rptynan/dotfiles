#!/bin/zsh

function _prompt_k8s_info {
  local _kns=$(kubens -c 2>/dev/null)
  local _kctx=$(kubectl config current-context 2>/dev/null)
  [[ -n "$_kns$_kctx" ]] && echo "🚡 %F{3}$_kns %F{7}$_kctx"
}

# Override sorin prompt: two-line layout with time, git, and exit code on line 2
PROMPT='${SSH_TTY:+"%F{9}%n%f%F{7}@%f%F{3}%m%f "}%F{4}${_prompt_sorin_pwd}%f %50<…<${_prompt_sorin_git}%<< %50>…>$(_prompt_k8s_info)%>>
%F{7}%T%f%(?:: %F{1}✘ %?%f)%(!. %B%F{1}#%f%b.)${editor_info[keymap]} '
RPROMPT='$python_info[virtualenv]${editor_info[overwrite]}${VIM:+" %B%F{6}V%f%b"}'

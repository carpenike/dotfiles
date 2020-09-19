set -x GPG_TTY (tty)

set -gx PATH $PATH /home/ryan/bin
set -gx PATH $PATH $HOME/.krew/bin
set -gx PATH $PATH $HOME/.local/bin

set -gx FLUX_FORWARD_NAMESPACE flux
set -gx DATASTORE_TYPE kubernetes

set -x SSH_AUTH_SOCK $HOME/.ssh/agent.sock
ss -a | grep -q $SSH_AUTH_SOCK
if [ $status != 0 ]
  rm -f $SSH_AUTH_SOCK
  setsid nohup socat UNIX-LISTEN:$SSH_AUTH_SOCK,fork EXEC:/c/tools/wsl-ssh-pageant/wsl2-ssh-pageant.exe >/dev/null 2>&1 &
end

set -x GPG_AGENT_SOCK $HOME/.gnupg/S.gpg-agent
ss -a | grep -q $GPG_AGENT_SOCK
if [ $status != 0 ]
  rm -rf $GPG_AGENT_SOCK
  setsid nohup socat UNIX-LISTEN:$GPG_AGENT_SOCK,fork EXEC:"/c/tools/wsl-ssh-pageant/wsl2-ssh-pageant.exe --gpg S.gpg-agent" >/dev/null 2>&1 &
end

starship init fish | source

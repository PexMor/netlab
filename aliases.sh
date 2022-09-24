# file to include into current shell context via 'source aliases.sh'
alias rin='sudo ip netns exec netlab'
alias myssh='sudo ip netns exec netlab ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR'
alias mysftp='sudo ip netns exec netlab sftp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR'

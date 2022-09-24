# netlab

Network lab with container and netns

## Useful aliases

```bash
alias rin='sudo ip netns exec netlab'
# LC_ALL=C
alias myssh='sudo ip netns exec netlab ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR'
alias mysftp='sudo ip netns exec netlab sftp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR'
```


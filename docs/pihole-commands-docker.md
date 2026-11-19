# Using Pi-hole commands when Pi-hole is in Docker

When Pi-hole runs in Docker you normally cannot run `pihole -c` directly on the host.

## Option 1: Use the included wrapper

```bash
chmod +x pihole-docker

# Examples
./pihole-docker -c
./pihole-docker -g
./pihole-docker status
./pihole-docker -t
./pihole-docker restartdns
```

If your container has another name:

```bash
PIHOLE_CONTAINER=my-pihole ./pihole-docker -c
```

## Option 2: Create a permanent alias (recommended)

Add this to your `~/.bashrc` or `~/.zshrc`:

```bash
# Correct alias (avoids recursion)
alias pihole='docker exec -it pihole command pihole'
```

Or with a custom container name:

```bash
alias pihole='docker exec -it my-pihole command pihole'
```

Alternative (also safe):

```bash
alias pihole='docker exec -it pihole /usr/local/bin/pihole'
```

Then reload:

```bash
source ~/.bashrc
```

Now you can use the normal commands:

```bash
pihole -c
pihole -g
pihole status
```

## Option 3: One-liner without alias

```bash
docker exec -it pihole pihole -c
```

## Notes

- The `-it` flags are needed for interactive commands (like `pihole -c`).
- Using `command pihole` or the full path `/usr/local/bin/pihole` prevents alias recursion.
- Works with all standard Pi-hole CLI commands.

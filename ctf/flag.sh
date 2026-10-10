#!/bin/sh
# Upstream compiles the flag into /chroot/readflag. This replaces it at every start with a script that
# prints the player's flag (CTF_FLAG_MAIN, given by the launcher) the same way; without one
# (CI, a run by hand) the development flag. A script must be readable to run, so it is mode 555.
dev='CTF{dev-google-ctf-2024-pycalc}'
v="${CTF_FLAG_MAIN:-$dev}"
f=/chroot/readflag
rm -f "$f"
cat > "$f" <<EOF
#!/bin/sh
echo '$v'
EOF
chmod 555 "$f"

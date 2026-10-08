# Overlay of google-ctf 2024/quals/misc-pycalc/challenge/Dockerfile (vendored unchanged in app/).
# What differs from upstream:
# - Ubuntu 23.10 reached end of life and its packages moved to old-releases.ubuntu.com, so the chroot
#   stage points apt there before upstream's `apt-get update` (the added RUN line);
# - the COPY sources point into app/challenge/ (this folder is the build context).
# Everything else is upstream's, line for line.

FROM ubuntu:23.10 as chroot

RUN sed -i -E "s#http://(archive|security).ubuntu.com#http://old-releases.ubuntu.com#g" /etc/apt/sources.list $(ls /etc/apt/sources.list.d/*.sources 2>/dev/null)

RUN apt-get update \
    && apt-get install -yq --no-install-recommends python3 build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY app/challenge/readflag.c /
RUN gcc /readflag.c -o /readflag && rm /readflag.c && chmod -r+x /readflag
COPY app/challenge/main.py /home/user/

FROM gcr.io/kctf-docker/challenge@sha256:0f7d757bcda470c3bbc063606335b915e03795d72ba1d8fdb6f0f9ff3757364f

COPY --from=chroot / /chroot

COPY app/challenge/nsjail.cfg /home/user/

CMD kctf_setup && \
    kctf_drop_privs \
    socat \
      TCP-LISTEN:1337,reuseaddr,fork \
      EXEC:"kctf_pow nsjail -q --config /home/user/nsjail.cfg -- /usr/bin/python3 /home/user/main.py",pty

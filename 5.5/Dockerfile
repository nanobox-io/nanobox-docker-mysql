# -*- mode: Dockerfile; tab-width: 4;indent-tabs-mode: nil;-*-
# vim: ts=4 sw=4 ft=Dockerfile et: 1
FROM nanobox/runit

# Create directories
RUN mkdir -p /var/log/gonano

# Copy files
ADD hookit/. /opt/gonano/hookit/mod/
ADD hookit-5.5/. /opt/gonano/hookit/mod/
ADD files/. /

# Install binaries
RUN rm -rf /data/var/db/pkgin && \
    /data/bin/pkgin -y up && \
    /data/bin/pkgin -y in \
        galera \
        mysql-server-5.5 \
        mysql-client-5.5 && \
    rm -rf /data/var/db/pkgin/cache

# Install binaries
RUN rm -rf /opt/gonano/var/db/pkgin && \
    /opt/gonano/bin/pkgin -y up && \
    /opt/gonano/bin/pkgin -y in \
      rsync && \
    rm -rf /var/gonano/db/pkgin/cache


# Cleanup disk
RUN rm -rf \
        /var/lib/apt/lists/* \
        /tmp/* \
        /var/tmp/*

# Run runit automatically
CMD [ "/opt/gonano/bin/nanoinit" ]

# `Dockerfile` with no additions/extensions is effectively the 'latest' or default version offered
FROM nanobox/runit

# Create directories
RUN mkdir -p /var/log/gonano

# Copy files
ADD hookit/. /opt/gonano/hookit/mod/
ADD files/. /

RUN curl -s http://pkgsrc.nanobox.io/nanobox/base/Linux/bootstrap.tar.gz | tar -C / -zxf - && \
    echo "http://pkgsrc.nanobox.io/nanobox/base/Linux/" > /data/etc/pkgin/repositories.conf && \
    mkdir -p /data/var/db && \
    /data/sbin/pkg_admin rebuild && \
    rm -rf /data/var/db/pkgin && /data/bin/pkgin -y up && \
    /data/bin/pkgin -y in mysql-server-5.5 mysql-client-5.5 && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /data/var/db/pkgin

RUN echo '5.5' > /var/nano-service-version

# Run runit automatically
CMD /opt/gonano/bin/nanoinit

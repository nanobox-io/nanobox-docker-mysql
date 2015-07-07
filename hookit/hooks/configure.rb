
directory '/datas'

# chown datas for gonano
execute 'chown /datas' do
  command 'chown -R gonano:gonano /datas'
end

directory '/var/log/mysql' do
  owner 'gonano'
  group 'gonano'
end

template '/data/etc/my.cnf' do
  mode 0644
  owner 'gonano'
  group 'gonano'
  variables ({ user: "nanobox" })
end

execute 'mysql_install_db --basedir=/data --ldata=/datas --user=gonano --defaults-file=/data/etc/my.cnf' do
  user 'gonano'
  not_if { ::Dir.exists? '/datas/mysql' }
end

# Import service (and start)
directory '/etc/service/db' do
  recursive true
end

directory '/etc/service/db/log' do
  recursive true
end

template '/etc/service/db/log/run' do
  mode 0755
  source 'log-run.erb'
  variables ({ svc: "db" })
end

template '/etc/service/db/run' do
  mode 0755
  variables ({ exec: "mysqld --defaults-file=/data/etc/my.cnf --pid-file=/tmp/mysql.pid 2>&1" })
end

# Wait for server to start
until File.exists?( "/tmp/mysqld.sock" )
   sleep( 1 )
end

# Create nanobox user and databases
template '/tmp/setup.sql' do
  variables ({ 
    hostname: `hostname`.to_s.strip[-59..-1]
  })
  source 'setup.sql.erb'
end

execute 'setup user/permissions' do
  command <<-END
    /data/bin/mysql \
    -u root \
    -S /tmp/mysqld.sock \
      < /tmp/setup.sql
  END
end

# Configure narc
template '/opt/gonano/etc/narc.conf' do
  variables ({ uid: payload[:uid], app: "nanobox", logtap: payload[:logtap_uri] })
end

directory '/etc/service/narc'

file '/etc/service/narc/run' do
  mode 0755
  content <<-EOF
#!/bin/sh -e
export PATH="/opt/local/sbin:/opt/local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/gonano/sbin:/opt/gonano/bin"

exec /opt/gonano/bin/narcd /opt/gonano/etc/narc.conf
  EOF
end

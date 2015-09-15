
include Hooky::Mysql
boxfile = converge( BOXFILE_DEFAULTS, payload[:boxfile] )

version = File.read('/var/nano-service-version').to_f

# set my.cnf
template '/data/etc/my.cnf' do
  source 'my-galera.cnf.erb'
  mode 0644
  variables ({
    payload: payload,
    boxfile: boxfile,
    type:    'mysql',
    version: version,
    plugins: plugins(boxfile)
  })
  owner 'gonano'
  group 'gonano'
end

directory '/data/lib/svc/method' do
  recursive true
end

template '/data/lib/svc/method/mysqld' do
  source 'galera-mysqld.erb'
  owner 'gonano'
  group 'gonano'
  mode 0755
  variables ({
    payload: payload
  })
end

template '/etc/service/db/run' do
  mode 0755
  variables ({ exec: "/data/lib/svc/method/mysqld start 2>&1" })
end


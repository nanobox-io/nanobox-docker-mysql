
include Hooky::Mysql
boxfile = converge( BOXFILE_DEFAULTS, payload[:boxfile] ) 

# set my.cnf
template '/data/etc/my.cnf' do
  source 'my-galera.cnf.erb'
  mode 0644
  variables ({ 
    payload: payload,
    boxfile: boxfile, 
    type:    payload[:service][:scaffold_name], 
    version: payload[:image][:version], 
    plugins: plugins(boxfile) 
  })
  owner 'gopagoda'
  group 'gopagoda'
end

directory '/data/lib/svc/method' do
  recursive true
end

template '/data/lib/svc/method/mysqld' do
  source 'galera-mysqld.erb'
  owner 'gopagoda'
  group 'gopagoda'
  mode 0755
  variables ({
    payload: payload
  })
end

template '/etc/service/db/run' do
  mode 0755
  variables ({ exec: "/data/lib/svc/method/mysqld start 2>&1" })
end


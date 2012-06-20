directory "/var/log/railsready" do
  mode "0777"
  action :create
end

user "railsready" do
  username node[:railsready][:install][:user]
  home "/home/#{node[:railsready][:install][:user]}"
  shell "/bin/bash"
  comment "Temporary railsready install user"
  action :create
end

group "admin" do
  members [ node[:railsready][:install][:user] ]
end

directory "/home/#{node[:railsready][:install][:user]}" do
  owner node[:railsready][:install][:user]
  group "admin"
  mode "0755"
  action :create
end

bash "install-railsready" do
  user node[:railsready][:install][:user]
  cwd "/home/#{node[:railsready][:install][:user]}"
  environment({ "HOME" => "/home/#{node[:railsready][:install][:user]}" })
  creates "/var/log/railsready/INSTALLATION_SUCCESSFUL"
  code <<-EOH
    wget https://raw.github.com/joshfng/railsready/master/railsready.sh &&
    echo 1 | bash railsready.sh &&
    touch /var/log/railsready/INSTALLATION_SUCCESSFUL
  EOH
  action :run
end

user "railsready" do
  username node[:railsready][:install][:user]
  action :remove
end

directory "/home/#{node[:railsready][:install][:user]}" do
  action :delete
  recursive true
end

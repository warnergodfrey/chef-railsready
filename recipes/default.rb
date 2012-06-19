user "railsready" do
  username node[:railsready][:install][:user]
  group "admin"
  home "/home/railsready"
  shell "/bin/bash"
  comment "Temporary railsready install user"
  action :create
end

bash "install-railsready" do
  user node[:railsready][:install][:user]
  code <<-EOH
    wget https://raw.github.com/joshfng/railsready/master/railsready.sh &&
    echo 1 | bash railsready.sh &&
    rm railsready.sh
  EOH
  action :run
end

user "railsready" do
  username node[:railsready][:install][:user]
  action :remove
end

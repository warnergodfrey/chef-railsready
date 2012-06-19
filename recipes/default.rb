user "railsready" do
  username node[:railsready][:install][:user]
  group "admin"
  home "/home/railsready"
  shell "/bin/bash"
  comment "Temporary railsready install user"
  password "$6$eaxpjwDMs$QI1mPT9zw23V38P3W3A/0Wk.nDgfcpCRoAY53445zKq7BSx5F0uxZYp7HnirlW2NBPcDuAV8y6WRbZEGy5j2A."
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

user "railsready" do
  username node[:railsready][:install][:user]
  comment "Temporary railsready install user"
  password "$6$eaxpjwDMs$QI1mPT9zw23V38P3W3A/0Wk.nDgfcpCRoAY53445zKq7BSx5F0uxZYp7HnirlW2NBPcDuAV8y6WRbZEGy5j2A."
  action :add
end

sudo "railsready" do
  user node[:railsready][:install][:user]
  commands ["/tmp/railsready.sh"]
  host "ALL"
  nopasswd true
end

bash "install-railsready" do
  user node[:railsready][:install][:user]
  code <<-EOH
    wget -P /tmp https://raw.github.com/joshfng/railsready/master/railsready.sh &&
    cat 1 | bash /tmp/railsready.sh &&
    rm /tmp/railsready.sh
  EOH
  action :run
end

user "railsready" do
  username node[:railsready][:install][:user]
  action :remove
end

File "/etc/sudoers.d/railsready" do
  action :delete
end


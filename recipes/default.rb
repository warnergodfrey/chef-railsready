bash "install-railsready" do
  user node[:railsready][:install][:user]
  code <<-EOH
    wget -P /tmp https://raw.github.com/joshfng/railsready/master/railsready.sh
    cat 1 | bash /tmp/railsready.sh
    rm /tmp/railsready.sh
  EOH
  action :run
end

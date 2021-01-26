include_recipe 'chocolatey'

# Using seven_zip also for general zip files because it can download and extract in a single resource
include_recipe 'seven_zip'
include_recipe 'ros2_windows::visual_studio'
include_recipe 'ros2_windows::python'
include_recipe 'ros2_windows::pip_installs'
include_recipe 'ros2_windows::opencv'
include_recipe 'ros2_windows::openssl'
include_recipe 'ros2_windows::chocolatey_installs'
if node['ros2_windows']['qt5']['installation_method'] == 'online'
  include_recipe 'ros2_windows::qt5_online'
elsif node['ros2_windows']['qt5']['installation_method'] == 'offline'
  include_recipe 'ros2_windows::qt5_offline'
else
  Chef::Log.fatal("Unknown qt5 installation method #{node['ros2_windows']['qt5']['installation_method']}")
  raise
end
include_recipe 'ros2_windows::xmllint'

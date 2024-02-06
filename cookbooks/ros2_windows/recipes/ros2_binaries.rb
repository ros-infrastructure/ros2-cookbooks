release_version = node['ros2_windows']['ros_distro']
build_type = node['ros2_windows']['build_type']

remote_file 'C:\\ros2_windows.zip' do
  source node['ros2_windows'][release_version][build_type]
end

archive_file 'ros2' do
  path 'C:\\ros2_windows.zip'
  destination node['ros2_windows']['ros2_ws']
  action :extract
end

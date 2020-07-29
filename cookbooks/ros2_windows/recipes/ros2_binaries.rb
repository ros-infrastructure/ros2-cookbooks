release_version = node['ros2_windows']['ros_distro']
build_type = node['ros2_windows']['build_type']

seven_zip_archive 'ros2' do
  source node['ros2_windows'][release_version][build_type]
  path node['ros2_windows']['ros2_ws']
end

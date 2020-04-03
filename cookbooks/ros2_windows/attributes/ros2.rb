default['ros2_windows']['development'] = false

# 'dashing', 'eloquent', 'foxy', etc
default['ros2_windows']['release_version'] = 'eloquent'

# 'release' or 'debug'
default['ros2_windows']['build_type'] = 'release'

default['ros2_windows']['download_sources'] = true

# 'buildtools', 'community'
default['ros2_windows']['vs_version'] = 'buildtools'

# On a development machine use the release version, or 'master' for the latest
default['ros2_windows']['source']['ros2.repos'] = 'master'
default['ros2_windows']['ros2_ws'] = 'C:\\dev\\ros2_ws'

# Optional DDS vendors
default['ros2_windows']['install_connext'] = false
default['ros2_windows']['install_opensplice'] = false

# ROS 2 binary releases
default['ros2_windows']['eloquent']['release'] = 'https://github.com/ros2/ros2/releases/download/release-eloquent-20191122/ros2-eloquent-20191122-windows-release-amd64.zip'
default['ros2_windows']['eloquent']['debug'] = 'https://github.com/ros2/ros2/releases/download/release-eloquent-20191122/ros2-eloquent-20191122-windows-debug-amd64.zip'
default['ros2_windows']['dashing']['release'] = 'https://github.com/ros2/ros2/releases/download/release-dashing-20200319/ros2-dashing-20200319-windows-amd64.zip'
default['ros2_windows']['dashing']['debug'] = 'https://github.com/ros2/ros2/releases/download/release-dashing-20200319/ros2-dashing-20200319-windows-debug-amd64.zip'

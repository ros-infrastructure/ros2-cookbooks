# Name of the ros_distro to target with this installation.
default['ros2_windows']['ros_distro'] = 'rolling'

# github.com/ros2/ros2 branch version, "master", "dashing", "dashing-release", etc.
# Only used if downloading sources
default['ros2_windows']['source']['ros2.repos'] = 'master'

# Location of ros2 workspace
default['ros2_windows']['ros2_ws'] = 'C:\\dev\\ros2_ws'

# Binary build version, 'release' or 'debug'
default['ros2_windows']['build_type'] = 'release'

# Current binary locations, update as new releases become available
default['ros2_windows']['eloquent']['release'] = 'https://github.com/ros2/ros2/releases/download/release-eloquent-20191122/ros2-eloquent-20191122-windows-release-amd64.zip'
default['ros2_windows']['eloquent']['debug'] = 'https://github.com/ros2/ros2/releases/download/release-eloquent-20191122/ros2-eloquent-20191122-windows-debug-amd64.zip'
default['ros2_windows']['dashing']['release'] = 'https://github.com/ros2/ros2/releases/download/release-dashing-20200319/ros2-dashing-20200319-windows-amd64.zip'
default['ros2_windows']['dashing']['debug'] = 'https://github.com/ros2/ros2/releases/download/release-dashing-20200319/ros2-dashing-20200319-windows-debug-amd64.zip'

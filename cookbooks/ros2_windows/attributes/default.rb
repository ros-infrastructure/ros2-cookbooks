# True if setting up machine for ros2 development or false for binaries only
default['ros2_windows']['development'] = false

# ROS 2 binary versions, dashing/eloquent/foxy etc
default['ros2_windows']['release_version'] = 'eloquent'

# Binary build version, 'release' or 'debug'
default['ros2_windows']['build_type'] = 'release'

# In development, also download ros2 sources
default['ros2_windows']['download_sources'] = true

# Visual studio version, "buildtools" or "community"
default['ros2_windows']['vs_version'] = 'buildtools'

# github.com/ros2/ros2 branch version, "master", "dashing", "dashing-release", etc.
# Only used if downloading sources
default['ros2_windows']['source']['ros2.repos'] = 'master'

# Location of ros2 workspace, used for both development/binary configurations
default['ros2_windows']['ros2_ws'] = 'C:\\dev\\ros2_ws'

# Current binary locations, update as new releases become available
default['ros2_windows']['eloquent']['release'] = 'https://github.com/ros2/ros2/releases/download/release-eloquent-20191122/ros2-eloquent-20191122-windows-release-amd64.zip'
default['ros2_windows']['eloquent']['debug'] = 'https://github.com/ros2/ros2/releases/download/release-eloquent-20191122/ros2-eloquent-20191122-windows-debug-amd64.zip'
default['ros2_windows']['dashing']['release'] = 'https://github.com/ros2/ros2/releases/download/release-dashing-20200319/ros2-dashing-20200319-windows-amd64.zip'
default['ros2_windows']['dashing']['debug'] = 'https://github.com/ros2/ros2/releases/download/release-dashing-20200319/ros2-dashing-20200319-windows-debug-amd64.zip'

# Install additional DDS vendors
default['ros2_windows']['install_opensplice'] = false

default['ros2_windows']['install_connext'] = false

# MAJOR.MINOR.PATCH version of rti, match to your install package
default['ros2_windows']['rti_connext']['version'] = nil

# Edition of your connext installer ('evaluation', 'pro')
default['ros2_windows']['rti_connext']['edition'] = nil

# Match these to the values in your install package
default['ros2_windows']['rti_connext']['target_platform'] = 'x64Win64'
default['ros2_windows']['rti_connext']['min_vs_version'] = '2017'

# Path to your rti_connext installer file
default['ros2_windows']['rti_connext']['license_file'] = nil

# Path to the directory container your installer packages
default['ros2_windows']['rti_connext']['installer_dir'] = nil

# Openssl version used specifically for rti-connext, match to the installer package
default['ros2_windows']['rti_connext']['openssl_version'] = nil

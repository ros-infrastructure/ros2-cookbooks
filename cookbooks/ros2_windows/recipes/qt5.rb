directory 'AppData_Qt' do
  path File.join(Dir.home(), "AppData\\Roaming\\Qt")
end

# Installing Qt5 requires an account. This file contains a username and secret account token
cookbook_file 'qtaccount.ini' do
  path File.join(Dir.home(), "AppData\\Roaming\\Qt\\qtaccount.ini")
  source 'qtaccount.ini'
  action :create_if_missing

  # If the deploying user did not add this file to `files` continue anyway.
  ignore_failure true

  # Suppress diff output so we can use this in public builds.
  sensitive true
end

if node['ros2']['qt_account_email'].nil?
  raise "A Qt account is required to install Qt.\nSet the `['ros2']['qt_account_email']` attribute"
end
if node['ros2']['qt_account_password'].nil?
  raise "A Qt account is required to install Qt.\nSet the `['ros2']['qt_account_password']` attribute"
end

template  'qt-installer.qs' do
  source 'qt-installer.qs.erb'
  variables Hash[
    qt_account_email: node['ros2']['qt_account_email'],
    qt_account_password: node['ros2']['qt_account_password'],
  ]
  sensitive true
end

template  'qt-maintenance.qs' do
  source 'qt-maintenance.qs.erb'
  variables Hash[
    qt_account_email: node['ros2']['qt_account_email'],
    qt_account_password: node['ros2']['qt_account_password'],
  ]
  sensitive true
end

# Install Qt5 with automated install script, no msvc2019 version exists but 2017 is compatible
# Updater/silentUpdate options did not work for me.
# Install scripts finds and installs the most recent LTS version
error_filename = File.join(Dir.home(), "qt_install.err")

windows_package 'Qt Maintenance' do
  source 'c:\\Qt\\MaintenanceTool.exe'
  installer_type :custom
  # I couldn't find documentation, but return codes don't seem to correspond with an actual failure.
  # Instead error information is written to the ErrorLogname below
  returns [0, 1, 3]
  options '--script qt-maintenance.qs MsvcVersion=2019 ErrorLogname="' + error_filename + '"'
  timeout 2000
  only_if {::File.exist?('c:\\Qt\\MaintenanceTool.exe')}
end

windows_package 'Qt Install' do
  source 'http://download.qt.io/official_releases/online_installers/qt-unified-windows-x86-online.exe'
  installer_type :custom
  # I couldn't find documentation, but return codes don't seem to correspond with an actual failure.
  # Instead error information is written to the ErrorLogname below
  returns [0, 1, 3]
  options '--script qt-installer.qs MsvcVersion=2019 ErrorLogname="' + error_filename + '"'
  timeout 2000
  not_if {::File.exist?('c:\\Qt\\MaintenanceTool.exe')}
end

ruby_block 'error_exist?' do
  block do
    if ::File.exist?(error_filename)
      raise 'Error install Qt5, see ' + error_filename
    end
  end
end

# Install Qt5 with automated install script, no msvc2019 version exists but 2017 is compatible
# Updater/silentUpdate options did not work for me.
# Using the online installer will find and install the most recent LTS version.
directory 'AppData_Qt' do
  path File.join(Dir.home(), "AppData\\Roaming\\Qt")
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

error_filename = File.join(Dir.home(), "qt_install.err")

if node['ros2_windows']['qt5']['installation_method'] == 'online'
  template  'qt-maintenance.qs' do
    source 'qt-maintenance.qs.erb'
    variables Hash[
      qt_account_email: node['ros2']['qt_account_email'],
      qt_account_password: node['ros2']['qt_account_password'],
    ]
    sensitive true
  end

  # Update maintenance tool first, if necessary
  windows_package 'Qt Maintenance Update' do
    source 'c:\\Qt\\MaintenanceTool.exe'
    installer_type :custom
    # I couldn't find documentation, but return codes don't seem to correspond with an actual failure.
    # Instead error information is written to the ErrorLogname below
    returns [0]
    options 'up qt.tools.maintenance'
    timeout 600
    only_if {::File.exist?('c:\\Qt\\MaintenanceTool.exe')}
  end

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
elsif node['ros2_windows']['qt5']['installation_method'] == 'offline'
  qt_mirror_url = node['ros2_windows']['qt5']['qt_mirror_url']
  error_filename = File.join(Dir.home(), "qt_install.err")
  windows_package 'Qt Install' do
    # Qt 5.12 was the last version of Qt to be provided an offline installer for open source usage.
    source "#{qt_mirror_url}/archive/qt/5.12/5.12.10/qt-opensource-windows-x86-5.12.10.exe"
    checksum "e315ec89000ae08d51c248f251ce670036b565e1d3a07df50e32557b8fd8246e"
    installer_type :custom
    # I couldn't find documentation, but return codes don't seem to correspond with an actual failure.
    # Instead error information is written to the ErrorLogname below
    returns [0, 1, 3]
    options %{--st "#{qt_mirror_url}" --script qt-installer.qs --verbose MsvcVersion=2019 ErrorLogname="#{error_filename}"}
    timeout 2000
    not_if {::File.exist?('c:\\Qt\\Qt5.12.10\\MaintenanceTool.exe')}
  end
else
  raise "Unknown qt5 installation method #{node['ros2_windows']['qt5']['installation_method']}"
end

ruby_block 'error_exist?' do
  block do
    if ::File.exist?(error_filename)
      raise 'Error install Qt5, see ' + error_filename
    end
  end
end

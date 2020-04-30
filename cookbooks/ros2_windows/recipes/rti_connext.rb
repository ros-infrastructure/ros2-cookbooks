connext_params = node['ros2_windows']['rti_connext']

# These will fail if the rti_connext parameters have not been specified because the defaults are 'nil'
unless File.exists?(connext_params['license_file']) do
  Chef::Log.fatal("License file location does not exist: #{connext_params['license_file']}")
  raise
end

unless Dir.exists?(connext_params['installer_dir']) do
  Chef::Log.fatal("Installer directory does not exist: #{connext_params['installer_dir']}")
  raise
end

if connext_params['version'] == nil do
  Chef::Log.fatal("Version is nil, requires MAJOR.MINOR.PATCH (e.g. '5.3.1')")
  raise
end

if connext_params['edition'] == nil do
  Chef::Log.fatal("Edition is nil, requires one of ('evaluation', 'pro')")
  raise
end

if connext_params['min_vs_version'] == nil do
  Chef::Log.fatal("Minimum Visual Studio version is required (e.g. '2017')")
  raise
end

if connext_params['openssl_version'] == nil do
  Chef::Log.fatal("OpenSSL version is required (e.g. '1.0.2n')")
  raise
end

host_installer_filename = "rti_connext_dds-#{connext_params['version']}-#{connext_params['edition']}-host-#{connext_params['target_platform']}.exe")
host_installer_path = File.join(connext_params['installer_dir'], host_installer_filename)

target_platform_vs_version = connext_params['target_platform'] + 'VS' + connext_params['min_vs_version']

openssl_installer_path = File.join(connext_params['installer_dir'],
                                   "openssl-#{connext_params['openssl_version']}-target-#{target_platform_vs_version}.zip")

target_installer_filename = "rti_connext_dds-#{connext_params['version']}-#{connext_params['edition']}-target-#{target_platform_vs_version}.rtipkg"
target_installer_path = File.join(connext_params['installer_dir'],
                                  target_installer_filename)

rtipkginstall_bat = File.join('%ProgramFiles%',
                              "rti_connext_dds-#{connext_params['version']}",
                              'bin',
                              'rtipkginstall.bat')

security_plugins_host_filename = "rti_security_plugins-#{connext_params['version']}-host-#{connext_params['target_platform']}.rtipkg")
security_plugins_host_path = File.join(connext_params['installer_dir'], security_plugins_host_filename)

security_plugins_target_filename = "rti_security_plugins-#{connext_params['version']}-target-#{target_platform_vs_version}.rtipkg")

security_plugins_target_path = File.join(connext_params['installer_dir'], security_plugins_target_filename)

rti_openssl_base_dir = File.join('C:\\connext',
                                 "openssl-#{connext_params['openssl_version']}",
                                 target_platform_vs_version,
                                 'release')

log 'connext_install_message' do
  message 'Using the following paths for RTI Connext install: ' +
           'License file: ' + connext_params['license_file'] +
           ', Host installer: ' + host_installer_path +
           ', Target installer: ' + target_installer_path +
           ', Openssl installer: ' + openssl_installer_path +
           ', Host security plugins installer: ' + security_plugins_host_path +
           ', Target security plugins installer: ' + security_plugins_target_path +
           ', Installed openssl dir: ' + rti_openssl_base_dir +
           ', rtipkg batch script: ' + rtipkginstall_bat
  level :info
end

directory "C:\\connext" do
  path "C:\\connext"
  action :create
end

execute 'copy_license_file' do
  command "copy #{connext_params['license_file']} C:\\connext\\"
end

execute 'copy_connextdds_host' do
  command "copy /b #{host_installer_path}.??? #{host_installer_path}"
end

seven_zip_archive 'openssl_zip' do
  path 'C:\\connext\\'
  source openssl_installer_path
  overwrite true
end

execute 'copy_connextdds_target' do
  command "copy /b #{target_installer_filename}.??? #{target_installer_filename}"
end

windows_env 'RTI_LICENSE_FILE' do
  key_name 'RTI_LICENSE_FILE'
  value 'C:\\connext\\rti_license.dat'
  action :create
end

windows_package 'rti_connext' do
  source host_installer_path
  options '--mode unattended --unattendedmodeui minimalWithDialogs --prefix "%ProgramFiles%"'
end

execute 'rtipkginstall_openssl' do
  command  rtipkginstall_bat + ' ' + openssl_installer_path
end

execute 'rtipkginstall_rti_connext_dds_target' do
  command rtipkginstall_bat + ' ' + target_installer_path
end

execute 'rtipkginstall_rti_security_plugins_host' do
  command rtipkginstall_bat + ' ' + security_plugins_host_path
end

execute 'rtipkginstall_rti_security_plugins_target' do
  command rtipkginstall_bat + ' ' + security_plugins_target_path
end

windows_env 'RTI_OPENSSL_BIN' do
  key_name 'RTI_OPENSSL_BIN'
  value File.join(rti_openssl_base_dir, 'bin')
  action :create
end

windows_env 'RTI_OPENSSL_LIB' do
  key_name 'RTI_OPENSSL_LIB'
  value File.join(rti_openssl_base_dir, 'lib')
  action :create
end

connext_params = node['ros2_windows']['rti_connext']

# These will fail if the rti_connext parameters have not been specified because the defaults are 'nil'
assert(File.exists?(connext_params['license_file']),
                   sprintf('License file location does not exist: %s',
                           connext_params['license_file']))

assert(Dir.exists?(connext_params['installer_dir']),
                   sprintf('Installer directory does not exist: %s',
                           connext_params['installer_dir']))
assert_not_nil(connext_params['version'], "Version is nil, requires MAJOR.MINOR.PATCH (e.g. '5.3.1')")
assert_not_nil(connext_params['edition'], "Edition is nil, requires one of ('evaluation', 'pro')")

assert_not_nil(connext_params['min_vs_version'], "Minimum Visual Studio version is required (e.g. '2017')")

assert_not_nil(connext_params['openssl_version'], "OpenSSL version is required (e.g. '1.0.2n')")

host_installer_filename = sprintf('rti_connext_dds-%s-%s-host-%s.exe',
                                  connext_params['version'],
                                  connext_params['edition'],
                                  connext_params['target_platform'])
host_installer_path = File.join(connext_params['installer_dir'], host_installer_filename)

target_platform_vs_version = connext_params['target_platform'] + 'VS' + connext_params['min_vs_version']

openssl_installer_path = File.join(connext_params['installer_dir'],
                                   sprintf('openssl-%s-target-%s.zip',
                                           connext_params['openssl_version'],
                                           target_platform_vs_version))

target_installer_filename = sprintf('rti_connext_dds-%s-%s-target-%s.rtipkg',
                                    connext_params['version'],
                                    connext_params['edition'],
                                    target_platform_vs_version)
target_installer_path = File.join(connext_params['installer_dir'],
                                  target_installer_filename)

rtipkginstall_bat = File.join('%ProgramFiles%',
                              sprintf('rti_connext_dds-%s', connext_params['version']),
                              'bin',
                              'rtipkginstall.bat')

security_plugins_host_filename = sprintf('rti_security_plugins-%s-host-%s.rtipkg',
                                         connext_params['version'],
                                         connext_params['target_platform'])
security_plugins_host_path = File.join(connext_params['installer_dir'], security_plugins_host_filename)

security_plugins_target_filename = sprintf('rti_security_plugins-%s-target-%s.rtipkg',
                                           connext_params['version'],
                                           target_platform_vs_version)

security_plugins_target_path = File.join(connext_params['installer_dir'], security_plugins_target_filename)

rti_openssl_base_dir = File.join('C:\\connext',
                                 sprintf('openssl-%s', connext_params['openssl_version']),
                                 target_platform_vs_version,
                                 'release')

print "--------------------------RTI Connext Install params--------------------------"
print 'License file: ' + connext_params['license_file']
print 'Host installer: ' + host_installer_path
print 'Target installer: ' + target_installer_path
print 'Openssl installer: ' + openssl_installer_path
print 'Host security plugins installer: ' + security_plugins_host_path
print 'Target security plugins installer: ' + security_plugins_target_path
print 'Installed openssl dir: ' + rti_openssl_base_dir
print 'rtipkg batch script: ' + rtipkginstall_bat
print "------------------------------------------------------------------------------"

directory "C:\\connext" do
  path "C:\\connext"
  action :create
end

execute 'copy_license_file' do
  command sprintf('copy %s C:\\connext\\', connext_params['license_file'])
end

execute 'copy_connextdds_host' do
  command sprintf('copy /b %s.??? %s', host_installer_path, host_installer_path)
end

seven_zip_archive 'openssl_zip' do
  path 'C:\\connext\\'
  source openssl_installer_path
  overwrite true
end

execute 'copy_connextdds_target' do
  command sprintf('copy /b %s.??? %s', target_installer_filename, target_installer_filename)
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

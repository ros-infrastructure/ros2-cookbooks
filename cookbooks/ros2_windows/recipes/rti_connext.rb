if !node['ros2_windows']['install_connext']
  return
end

directory "C:\\connext" do
  path "C:\\connext"
  action :create_if_missing
end

execute 'copy_license_file' do
  command 'copy rticonnextdds-license\\rti_license.dat C:\\connext\\'
end

execute 'copy_connextdds_host' do
  command 'copy /b rticonnextdds-src\\rti_connext_dds-5.3.1-pro-host-x64Win64.exe.??? rticonnextdds-src\\rti_connext_dds-5.3.1-pro-host-x64Win64.exe'
end

seven_zip_archive 'openssl_zip' do
  path 'C:\\opencv'
  source 'rticonnextdds-src\\openssl-1.0.2n-target-x64Win64VS2017.zip'
  overwrite true
end

execute 'copy_connextdds_target' do
  command 'copy /b rticonnextdds-src\\rti_connext_dds-5.3.1-pro-target-x64Win64VS2017.rtipkg.??? rticonnextdds-src\\rti_connext_dds-5.3.1-pro-target-x64Win64VS2017.rtipkg'
end

windows_env 'RTI_LICENSE_FILE' do
  key_name 'RTI_LICENSE_FILE'
  value 'C:\\connext\\rti_license.dat'
  action :create
end

windows_package 'rti_connext' do
  source 'rticonnextdds-src\\rti_connext_dds-5.3.1-pro-host-x64Win64.exe'
  options '--mode unattended --unattendedmodeui minimalWithDialogs --prefix "%ProgramFiles%"'
end

execute 'rtipkginstall_openssl' do
  command '%ProgramFiles%\rti_connext_dds-5.3.1\bin\rtipkginstall.bat rticonnextdds-src\openssl-1.0.2n-5.3.1-host-x64Win64.rtipkg'
end

execute 'rtipkginstall_rti_connext_dds_target' do
  command '%ProgramFiles%\rti_connext_dds-5.3.1\bin\rtipkginstall.bat rticonnextdds-src\\rti_connext_dds-5.3.1-pro-target-x64Win64VS2017.rtipkg'
end

execute 'rtipkginstall_rti_security_plugins_host' do
  command '%ProgramFiles%\rti_connext_dds-5.3.1\bin\rtipkginstall.bat rticonnextdds-src\rti_security_plugins-5.3.1-host-x64Win64.rtipkg'
end

execute 'rtipkginstall_rti_security_plugins_target' do
  command '%ProgramFiles%\rti_connext_dds-5.3.1\bin\rtipkginstall.bat rticonnextdds-src\rti_security_plugins-5.3.1-target-x64Win64VS2017.rtipkg'
end

windows_env 'RTI_OPENSSL_BIN' do
  key_name 'RTI_OPENSSL_BIN'
  value ' C:\\connext\\openssl-1.0.2n\\x64Win64VS2017\\release\\bin'
  action :create
end

windows_env 'RTI_OPENSSL_LIB' do
  key_name 'RTI_OPENSSL_LIB'
  value ' C:\\connext\\openssl-1.0.2n\\x64Win64VS2017\\release\\lib'
  action :create
end

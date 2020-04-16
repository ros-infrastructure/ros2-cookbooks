seven_zip_archive 'opensplice' do
  path 'C:\opensplice'
  source 'https://github.com/ADLINK-IST/opensplice/releases/download/OSPL_V6_9_190925OSS_RELEASE/PXXX-VortexOpenSplice-6.9.190925OSS-HDE-x86_64.win-vs2019-installer.zip'
  overwrite true
end

windows_env 'OSPL_HOME' do
  key_name 'OSPL_HOME'
  value 'C:\\opensplice\\HDE\\x86_64.win64'
  action :create
end

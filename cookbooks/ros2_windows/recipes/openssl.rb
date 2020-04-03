windows_package 'openssl' do
  source 'https://slproweb.com/download/Win64OpenSSL-1_0_2u.exe'
  options '/VERYSILENT'
end

windows_env 'OPENSSL_CONF' do
  key_name 'OPENSSL_CONF'
  value 'C:\\OpenSSL-Win64\\bin\\openssl.cfg'
  action :create
end

windows_env 'PATH' do
  key_name 'PATH'
  value 'C:\\OpenSSL-Win64\\bin'
  delim ';'
  action :modify
end

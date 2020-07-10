openssl_versions = {
  "dashing" => "1_0_2u",
  "eloquent" => "1_0_2u",
  "foxy" => "1_1_1g",
  "rolling" => "1_1_1g",
}.freeze

openssl_version = openssl_versions[node["ros2_windows"]["ros_distro"]]
openssl_conf_dir = if openssl_version == "1_1_1g"
                     'C:\\Program Files\\OpenSSL-Win64'
                   else
                     'C:\\OpenSSL-Win64'
                   end


windows_package 'openssl' do
  source "https://slproweb.com/download/Win64OpenSSL-#{openssl_version}.exe"
  options '/VERYSILENT'
end

windows_env 'OPENSSL_CONF' do
  key_name 'OPENSSL_CONF'
  value "#{openssl_conf_dir}\\bin\\openssl.cfg"
  action :create
end

windows_env 'PATH' do
  key_name 'PATH'
  value "#{openssl_conf_dir}\\bin"
  delim ';'
  action :modify
end

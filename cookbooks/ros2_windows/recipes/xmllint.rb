seven_zip_archive 'libxml2' do
  path 'C:\\xmllint'
  source 'https://www.zlatkovic.com/pub/libxml/64bit/libxml2-2.9.3-win32-x86_64.7z'
  overwrite true
end

seven_zip_archive 'zlib' do
  path 'C:\\xmllint'
  source 'https://www.zlatkovic.com/pub/libxml/64bit/zlib-1.2.8-win32-x86_64.7z'
  overwrite true
end

seven_zip_archive 'iconv' do
  path 'C:\\xmllint'
  source 'https://www.zlatkovic.com/pub/libxml/64bit/iconv-1.14-win32-x86_64.7z'
  overwrite true
end

windows_env 'PATH' do
  key_name 'PATH'
  value 'C:\\xmllint\\bin'
  delim ';'
  action :modify
end

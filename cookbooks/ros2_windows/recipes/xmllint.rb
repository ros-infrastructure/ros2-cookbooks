remote_file 'C:\\libxml2-2.9.3-win32-x86_64.7z' do
  source 'https://www.zlatkovic.com/pub/libxml/64bit/libxml2-2.9.3-win32-x86_64.7z'
end
remote_file 'C:\\zlib-1.2.8-win32-x86_64.7z' do
  source 'https://www.zlatkovic.com/pub/libxml/64bit/zlib-1.2.8-win32-x86_64.7z'
end
remote_file 'C:\\iconv-1.14-win32-x86_64.7z' do
  source 'https://www.zlatkovic.com/pub/libxml/64bit/iconv-1.14-win32-x86_64.7z'
end

archive_file 'libxml2' do
  destination 'C:\\xmllint'
  path 'C:\\libxml2-2.9.3-win32-x86_64.7z'
  overwrite true
end

archive_file 'zlib' do
  destination 'C:\\xmllint'
  path 'C:\\zlib-1.2.8-win32-x86_64.7z'
  overwrite true
end

archive_file 'iconv' do
  destination 'C:\\xmllint'
  path 'C:\\iconv-1.14-win32-x86_64.7z'
  overwrite true
end

windows_env 'PATH' do
  key_name 'PATH'
  value 'C:\\xmllint\\bin'
  delim ';'
  action :modify
end

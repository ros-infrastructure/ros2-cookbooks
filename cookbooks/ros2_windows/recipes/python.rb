windows_package 'python' do
  source 'https://www.python.org/ftp/python/3.7.6/python-3.7.6-amd64.exe'
  options '/quiet TargetDir=C:\\Python37 PrependPath=1 Include_debug=1 Include_symbols=1'
end

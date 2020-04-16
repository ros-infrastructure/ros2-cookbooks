chocolatey_package 'choco_packages' do
  package_name ['git', 'cmake', 'curl', 'vcredist2013', 'vcredist140', 'cppcheck', 'patch']
  # Installs if not installed, otherwise it will upgrade
  action :upgrade
end

windows_env 'PATH' do
  key_name 'PATH'
  value 'C:\\Program Files\\Git\\cmd;C:\\Program Files\\CMake\\bin'
  delim ';'
  action :modify
end

# Custom choco packages
remote_file 'asio.nupkg' do
  source 'https://github.com/ros2/choco-packages/releases/download/2019-10-24/asio.1.12.1.nupkg'
  action :create
end

remote_file 'cunit.nupkg' do
  source 'https://github.com/ros2/choco-packages/releases/download/2019-10-24/cunit.2.1.3.nupkg'
  action :create
end

remote_file 'eigen.nupkg' do
  source 'https://github.com/ros2/choco-packages/releases/download/2019-10-24/eigen.3.3.4.nupkg'
  action :create
end

remote_file 'log4cxx.nupkg' do
  source 'https://github.com/ros2/choco-packages/releases/download/2019-10-24/log4cxx.0.10.0.nupkg'
  action :create
end

remote_file 'tinyxml-usestl.nupkg' do
  source 'https://github.com/ros2/choco-packages/releases/download/2019-10-24/tinyxml-usestl.2.6.2.nupkg'
  action :create
end

remote_file 'tinyxml2.nupkg' do
  source 'https://github.com/ros2/choco-packages/releases/download/2019-10-24/tinyxml2.6.0.0.nupkg'
  action :create
end

chocolatey_package 'custom_packages' do
  package_name ['asio', 'cunit', 'eigen', 'tinyxml-usestl', 'tinyxml2', 'log4cxx']
  source '.\\'
end

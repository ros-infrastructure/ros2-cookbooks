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

custom_chocolatey_packages = %w[
  asio.1.12.1
  bullet.2.89.0
  cunit.2.1.3
  eigen.3.3.4
  log4cxx.0.10.0
  tinyxml-usestl.2.6.2
  tinyxml2.6.0.0
]

custom_chocolatey_packages.each do |pkg|
  remote_file "#{pkg}.nupkg" do
    source "https://github.com/ros2/choco-packages/releases/download/2020-02-24/#{pkg}.nupkg"
  end
end

chocolatey_package 'custom_packages' do
  package_name *custom_chocolatey_packages.map{|pkg| pkg.split('.').first}
  source '.\\'
end

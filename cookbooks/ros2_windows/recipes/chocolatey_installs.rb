%w[git cmake cppcheck curl vcredist2013 vcredist140 patch].each do |pkg|
  chocolatey_package pkg
end

windows_env 'PATH' do
  key_name 'PATH'
  value 'C:\\Program Files\\Git\\cmd;C:\\Program Files\\CMake\\bin'
  delim ';'
  action :modify
end

custom_chocolatey_packages = {
  'asio' => 'asio.1.12.1',
  'bullet' => 'bullet.2.89.0',
  'cunit' => 'cunit.2.1.3',
  'eigen' => 'eigen.3.3.4',
  'log4cxx' => 'log4cxx.0.10.0',
  'tinyxml-usestl' => 'tinyxml-usestl.2.6.2',
  'tinyxml2' => 'tinyxml2.6.0.0'
}

custom_chocolatey_packages.each do |name, pkg|
  remote_file "#{pkg}.nupkg" do
    source "https://github.com/ros2/choco-packages/releases/download/2020-02-24/#{pkg}.nupkg"
  end

  chocolatey_package 'custom_packages' do
    package_name "#{name}"
    source '.\\'
  end
end

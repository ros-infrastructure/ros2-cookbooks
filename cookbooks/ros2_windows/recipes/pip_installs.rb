required_pip_packages = %w[
  pydot
  PyQt5==5.15.0
  vcstool
  colcon-common-extensions
  catkin_pkg
  cryptography
  EmPy
  lark-parser
  lxml
  netifaces
  numpy
  opencv-python
  pyparsing
  pyyaml
  pytest
  pytest-mock
  coverage
  mock
]

ros2doctor_network_dependency = {
  "foxy" => "ifcfg",
  "galactic" => "ifcfg",
  "rolling" => "psutil",
}.freeze


required_pip_packages << ros2doctor_network_dependency[node["ros2_windows"]["ros_distro"]]

development_pip_packages = %w[
  flake8
  flake8-blind-except
  flake8-builtins
  flake8-class-newline
  flake8-comprehensions
  flake8-deprecated
  flake8-docstrings
  flake8-import-order
  flake8-quotes
  pep8
  pydocstyle
]

mypy_version = {
  "foxy" => "mypy==0.761",
  "galactic" => "mypy==0.761",
  "rolling" => "mypy==0.931",
}.freeze

development_pip_packages << mypy_version[node["ros2_windows"]["ros_distro"]]

# Use explicit location because python may not be on the PATH if chef-solo has not been run before
#
execute 'pip_update' do
  command lazy {
    "#{node.run_state[:python_dir]}\\python.exe -m pip install -U pip setuptools"
  }
end

execute 'pip_required' do
  command lazy {
    "#{node.run_state[:python_dir]}\\python.exe -m pip install -U #{required_pip_packages.join(' ')}"
  }
end

if node['ros2_windows']['development'] == true
  execute 'pip_additional' do
    command lazy {
      "#{node.run_state[:python_dir]}\\python.exe -m pip install -U #{development_pip_packages.join(' ')}"
    }
  end
end

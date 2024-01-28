required_pip_versions = {
  "humble" => {
    "argcomplete" => "1.8.1",
    "catkin_pkg" => "1.0.0",
    "colcon-argcomplete" => "0.3.3",
    "colcon-common-extensions" => "0.3.0",
    "colcon-defaults" => "0.2.8",
    "colcon-mixin" => "0.2.3",
    "coverage" => "6.2",
    "cryptography" => "3.4.8",
    "EmPy" => "3.3.4",
    "jsonschema" => "3.2.0",
    "lark" => "1.1.1",
    "lxml" => "4.8.0",
    "netifaces" => "0.11.0",
    "numpy" => "1.21.5",
    "opencv-python" => "4.6.0.66",
    "psutil" => "5.9.0",
    "pydot" => "1.4.2",
    "pyparsing" => "2.4.7",
    "PyQt5" => "5.15.0",
    "pytest" => "6.2.5",
    "pytest-mock" => "3.6.1",
    "pyyaml" => "5.4.1",
    "vcstool" => "0.3.0",
  },
  "iron" => {
    "argcomplete" => "1.8.1",
    "catkin_pkg" => "1.0.0",
    "colcon-argcomplete" => "0.3.3",
    "colcon-common-extensions" => "0.3.0",
    "colcon-defaults" => "0.2.8",
    "colcon-mixin" => "0.2.3",
    "coverage" => "6.2",
    "cryptography" => "3.4.8",
    "EmPy" => "3.3.4",
    "jsonschema" => "3.2.0",
    "lark" => "1.1.1",
    "lxml" => "4.8.0",
    "netifaces" => "0.11.0",
    "numpy" => "1.21.5",
    "opencv-python" => "4.6.0.66",
    "psutil" => "5.9.0",
    "pydot" => "1.4.2",
    "pyparsing" => "2.4.7",
    "PyQt5" => "5.15.0",
    "pytest" => "6.2.5",
    "pytest-mock" => "3.6.1",
    "pyyaml" => "5.4.1",
    "vcstool" => "0.3.0",
  },
  "rolling" => {
    "argcomplete" => "1.8.1",
    "catkin_pkg" => "1.0.0",
    "colcon-argcomplete" => "0.3.3",
    "colcon-common-extensions" => "0.3.0",
    "colcon-defaults" => "0.2.8",
    "colcon-mixin" => "0.2.3",
    "coverage" => "6.2",
    "cryptography" => "3.4.8",
    "EmPy" => "3.3.4",
    "jsonschema" => "3.2.0",
    "lark" => "1.1.1",
    "lxml" => "4.8.0",
    "numpy" => "1.21.5",
    "opencv-python" => "4.6.0.66",
    "psutil" => "5.9.0",
    "pydot" => "1.4.2",
    "pyparsing" => "2.4.7",
    "PyQt5" => "5.15.0",
    "pytest" => "6.2.5",
    "pytest-mock" => "3.6.1",
    "pyyaml" => "5.4.1",
    "vcstool" => "0.3.0",
  },
}.freeze

development_pip_versions = {
  "humble" => {
    "flake8" => "4.0.1",
    "flake8-blind-except" => "0.2.0",
    "flake8-builtins" => "1.5.3",
    "flake8-class-newline" => "1.6.0",
    "flake8-comprehensions" => "3.8.0",
    "flake8-deprecated" => "1.3",
    "flake8-docstrings" => "1.6.0",
    "flake8-import-order" => "0.18.1",
    "flake8-quotes" => "3.3.1",
    "mypy" => "0.942",
    "pydocstyle" => "6.1.1",
    "pyflakes" => "2.4.0",
    "pytest-cov" => "3.0.0",
    "pytest-repeat" => "0.9.1",
    "pytest-rerunfailures" => "10.2",
    "pytest-timeout" => "2.1.0",
  },
  "iron" => {
    "flake8" => "4.0.1",
    "flake8-blind-except" => "0.2.0",
    "flake8-builtins" => "1.5.3",
    "flake8-class-newline" => "1.6.0",
    "flake8-comprehensions" => "3.8.0",
    "flake8-deprecated" => "1.3",
    "flake8-docstrings" => "1.6.0",
    "flake8-import-order" => "0.18.1",
    "flake8-quotes" => "3.3.1",
    "mypy" => "0.942",
    "pydocstyle" => "6.1.1",
    "pyflakes" => "2.4.0",
    "pytest-cov" => "3.0.0",
    "pytest-repeat" => "0.9.1",
    "pytest-rerunfailures" => "10.2",
    "pytest-timeout" => "2.1.0",
  },
  "rolling" => {
    "flake8" => "4.0.1",
    "flake8-blind-except" => "0.2.0",
    "flake8-builtins" => "1.5.3",
    "flake8-class-newline" => "1.6.0",
    "flake8-comprehensions" => "3.8.0",
    "flake8-deprecated" => "1.3",
    "flake8-docstrings" => "1.6.0",
    "flake8-import-order" => "0.18.1",
    "flake8-quotes" => "3.3.1",
    "mypy" => "0.942",
    "pydocstyle" => "6.1.1",
    "pyflakes" => "2.4.0",
    "pytest-cov" => "3.0.0",
    "pytest-repeat" => "0.9.1",
    "pytest-rerunfailures" => "10.2",
    "pytest-timeout" => "2.1.0",
  },
}.freeze

pip_packages_versions = {}
pip_packages_versions.merge!(required_pip_versions[node["ros2_windows"]["ros_distro"]])
# TODO(clalancette): In theory, we should only add these for "development", but currently Windows
# CI doesn't set that so we unconditionally add it for now
pip_packages_versions.merge!(development_pip_versions[node["ros2_windows"]["ros_distro"]])

constraints_contents = ""
packages = ""
pip_packages_versions.each do |pkgname, version|
  constraints_contents += "#{pkgname}==#{version}\n"
  packages += "#{pkgname} "
end

constraints_path = File.join(node.run_state[:python_dir], 'constraints.txt')
file constraints_path do
  content "#{constraints_contents}"
end

# Use explicit location because python may not be on the PATH if chef-solo has not been run before
#
execute 'pip_update' do
  command lazy {
    "#{node.run_state[:python_dir]}\\python.exe -m pip install -U -c #{constraints_path} pip setuptools==59.6.0 "
  }
end

execute 'pip_packages' do
  command lazy {
    "#{node.run_state[:python_dir]}\\python.exe -m pip install -c #{constraints_path} -U #{packages}"
  }
end

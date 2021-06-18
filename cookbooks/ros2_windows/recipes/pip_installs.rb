required_pip_packages = %w[
  pydot
  PyQt5==5.15.0
  vcstool
  colcon-common-extensions
  catkin_pkg
  cryptography
  EmPy
  ifcfg
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
  mypy==0.761
  pep8
  pydocstyle
]

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

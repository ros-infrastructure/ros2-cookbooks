required_pip_packages = [
  'pydot',
  'PyQt5',
  'vcstool',
  'colcon-common-extensions',
  'catkin_pkg',
  'cryptography',
  'EmPy',
  'ifcfg',
  'lark-parser',
  'lxml',
  'netifaces',
  'numpy',
  'opencv-python',
  'pyparsing',
  'pyyaml',
  'pytest',
  'pytest-mock',
  'coverage',
  'mock'
]

development_pip_packages = [
  'flake8',
  'flake8-blind-except',
  'flake8-builtins',
  'flake8-class-newline',
  'flake8-comprehensions',
  'flake8-deprecated',
  'flake8-docstrings',
  'flake8-import-order',
  'flake8-quotes',
  'mypy',
  'pep8',
  'pydocstyle'
]

execute 'pip_update' do
  command 'pip install -U pip setuptools'
end

execute 'pip_required' do
  command 'pip install -U ' + required_pip_packages.join(' ')
end

if !node['ros2_windows']['development']
  execute 'pip_additional' do
    command 'pip install -U ' + development_pip_packages.join(' ')
  end
end

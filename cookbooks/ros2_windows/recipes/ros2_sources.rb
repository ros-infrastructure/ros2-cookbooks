directory 'ros2_ws' do
  path node['ros2_windows']['ros2_ws']
  action :create
  recursive true
end

ros2_src_dir = File.join(node['ros2_windows']['ros2_ws'], 'src')
directory 'ros2_ws_src' do
  path ros2_src_dir
  action :create
  recursive true
end

ros2_repos_path = File.join(node['ros2_windows']['ros2_ws'], 'ros2.repos')
remote_file 'ros2.repos' do
  source "https://raw.githubusercontent.com/ros2/ros2/#{node['ros2_windows']['source']['ros2.repos']}/ros2.repos"
  path ros2_repos_path
end

execute 'vcs_import' do
  command "C:\\Python37\\Scripts\\vcs.exe import --input #{ros2_repos_path} #{ros2_src_dir}"
end

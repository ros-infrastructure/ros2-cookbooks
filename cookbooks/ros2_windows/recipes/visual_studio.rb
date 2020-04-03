# For more information about command line arguments, see:
# https://docs.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio?view=vs-2019

# If BuildTools is not already installed, install it
packages_to_install =  [
  'Microsoft.Net.Component.4.8.SDK',
  'Microsoft.VisualStudio.Workload.VCTools',
  'Microsoft.Component.MSBuild',
  'Microsoft.VisualStudio.Component.VC.CLI.Support'
]

if node['ros2_windows']['vs_version'] != 'buildtools' do
  packages_to_install += ['Microsoft.VisualStudio.Workload.NativeDesktop',]
end

package_arguments = packages_to_install.map{ |pkg| '--add ' + pkg}.join(' ')
base_options = '--quiet --wait --norestart --includeRecommended '

installer_options = base_options + package_arguments

visual_studio_source = 'https://aka.ms/vs/16/release/vs_%s.exe' % node['ros2_windows']['vs_version']

vs_version_camel_case = {
  'buildtools' => 'BuildTools',
  'community' => 'Community',
  'professional' => 'Professional',
  'enterprise' => 'Enterprise'
}[node['ros2_windows']['vs_version']]

visual_studio_path = 'c:\\Program Files (x86)\\Microsoft Visual Studio\\2019\\%s' % vs_version_camel_case
windows_package 'Update VS' do
  source visual_studio_source
  installer_type :custom
  returns [0, 3010]
  options 'update ' + installer_options
  timeout 1200
  only_if {::Dir.exist?(visual_studio_path)}
end

windows_package 'Install vs_buildtools' do
  source visual_studio_source
  installer_type :custom
  action :install
  returns [0, 1605, 1614, 1641, 3010]
  options installer_options
  timeout 1200
  not_if {::Dir.exist?(visual_studio_path)}
end

windows_env 'VCTargetsPath' do
  key_name 'VCTargetsPath'
  value File.join(visual_studio_path, 'MSBuild\\Microsoft\\VC\\v160\\')
  action :create
end

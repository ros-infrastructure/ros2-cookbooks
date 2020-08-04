seven_zip_archive 'open_cv_zip' do
  path 'C:\\'
  source 'https://github.com/ros2/ros2/releases/download/opencv-archives/opencv-3.4.6-vc16.VS2019.zip'
  overwrite true
end

windows_env 'OpenCV_DIR' do
  key_name 'OpenCV_DIR'
  value 'C:\\opencv'
  action :create
end

windows_env 'PATH' do
  key_name 'PATH'
  value 'C:\\opencv\\x64\\vc16\\bin'
  delim ';'
  action :modify
end

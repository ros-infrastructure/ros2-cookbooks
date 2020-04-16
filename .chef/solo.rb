a_repo_dir = File.expand_path("../..", __FILE__)
cookbook_path [File.join(a_repo_dir, "vendor-cookbooks"), File.join(a_repo_dir, "cookbooks")]
data_bag_path File.join(a_repo_dir, "data_bags")
role_path File.join(a_repo_dir, "roles")
environment_path File.join(a_repo_dir, "environments")
solo true

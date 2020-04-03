REPO_DIR = File.expand_path "../..", __FILE__
cookbook_path [File.join(REPO_DIR, "vendor-cookbooks"), File.join(REPO_DIR, "cookbooks")]
role_path File.join(REPO_DIR, "roles")
solo true

external_url 'https://gitlab.ashlab.dev/'
gitlab_rails['initial_root_password'] = File.read('/run/secrets/gitlab_root_password')
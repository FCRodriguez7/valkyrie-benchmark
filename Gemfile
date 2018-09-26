source "https://rubygems.org"

gemspec

gem 'valkyrie', github: 'samvera-labs/valkyrie'
if File.exists?(File.expand_path("../../valkyrie-activerecord", __FILE__))
  gem 'valkyrie-activerecord', path: File.expand_path("../../valkyrie-activerecord", __FILE__)
else
  gem 'valkyrie-activerecord', github: 'durham-university/valkyrie-activerecord'
end
gem 'valkyrie-redis', github: 'samvera-labs/valkyrie-redis'
gem 'valkyrie-sequel', github: 'samvera-labs/valkyrie-sequel'

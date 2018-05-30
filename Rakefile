# frozen_string_literal: true
# Add your own tasks in files placed in lib/tasks ending in .rake,

require 'yaml'
require 'active_record'
require 'valkyrie'

task(:default).clear
task default: [:spec]

Dir['./lib/tasks/*.rake'].each do |rakefile|
  import rakefile
end

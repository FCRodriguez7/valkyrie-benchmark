# coding: utf-8
# frozen_string_literal: true
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "valkyrie_benchmark/version"

Gem::Specification.new do |spec|
  spec.name          = "valkyrie-benchmark"
  spec.version       = ValkyrieBenchmark::VERSION
  spec.authors       = ["Olli Lyytinen"]
  spec.email         = ["olli.lyytinen@durham.ac.uk"]

  spec.summary       = "Benchmarking different Valkyrie adapters"
  
  spec.files         = Dir["{config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]
  spec.require_paths = ["lib"]

  spec.add_dependency 'valkyrie'
  spec.add_dependency 'thor'
  spec.add_dependency 'benchmark-ips'
  spec.add_dependency 'byebug'
  spec.add_dependency 'activerecord'
  spec.add_dependency 'sqlite3'
  spec.add_dependency 'mysql2'
  spec.add_dependency 'valkyrie-activerecord'
  spec.add_dependency 'valkyrie-redis'
  spec.add_development_dependency 'fcrepo_wrapper'
  spec.add_development_dependency 'solr_wrapper'
  
end
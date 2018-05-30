require 'benchmark/ips'
require 'valkyrie'
require 'valkyrie/activerecord'
require 'byebug'

module ValkyrieBenchmark
  require 'valkyrie_benchmark/metadata_adapters'
  require 'valkyrie_benchmark/models'
  require 'valkyrie_benchmark/tests'
  require 'valkyrie_benchmark/runner'

  def self.enabled_metadata_adapters
    @enabled_metadata_adapters ||= all_metadata_adapters.select(&:enabled?)
  end

  def self.all_metadata_adapters
    @all_metadata_adapters ||= init_metadata_adapters
  end

  def self.enabled_test_suites
    @enabled_test_suites ||= all_test_suites.select(&:enabled?)
  end

  def self.all_test_suites
    @all_test_suites ||= ValkyrieBenchmark::Tests.all
  end

  def self.metadata_adapter_classes
    ValkyrieBenchmark::MetadataAdapters.all
  end

  def self.init_metadata_adapters
    metadata_adapter_classes.map do |cls| init_metadata_adapter(cls) end
  end

  def self.init_metadata_adapter(cls)
    cls.new
  end


end
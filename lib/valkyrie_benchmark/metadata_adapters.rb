module ValkyrieBenchmark
  module MetadataAdapters
    def self.register_metadata_adapter(adapter_class)
      @metadata_adapters = ((@metadata_adapters || []) + [adapter_class]).freeze
    end
        
    def self.all
      @metadata_adapters || []
    end

  end
end    

require 'valkyrie_benchmark/metadata_adapters/base_adapter'
require 'valkyrie_benchmark/metadata_adapters/active_record'
require 'valkyrie_benchmark/metadata_adapters/valkyrie_active_record'
require 'valkyrie_benchmark/metadata_adapters/active_record_mysql'
require 'valkyrie_benchmark/metadata_adapters/active_record_postgres'
require 'valkyrie_benchmark/metadata_adapters/active_record_sqlite'
require 'valkyrie_benchmark/metadata_adapters/postgres'
require 'valkyrie_benchmark/metadata_adapters/fedora'
require 'valkyrie_benchmark/metadata_adapters/solr'
require 'valkyrie_benchmark/metadata_adapters/redis'
require 'valkyrie_benchmark/metadata_adapters/memory'
require 'valkyrie_benchmark/metadata_adapters/sequel_postgres'

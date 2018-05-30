require 'valkyrie/redis'

module ValkyrieBenchmark
  module MetadataAdapters
    class Redis < BaseAdapter
      
      def valkyrie_adapter
        Valkyrie::Persistence::Redis::MetadataAdapter.new(
          redis: ::Redis.new(config[:redis].try(:except, :cache_prefix, :expiration) || {}),
          cache_prefix: config[:redis].try(:[], :cache_prefix) || '_valkyrie_benchmark_',
          expiration: config[:redis].try(:[], :expiration)
        )
      end

    end
  end
end

ValkyrieBenchmark::MetadataAdapters.register_metadata_adapter(ValkyrieBenchmark::MetadataAdapters::Redis)

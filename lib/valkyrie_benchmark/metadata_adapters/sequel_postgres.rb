require 'valkyrie/sequel'
module ValkyrieBenchmark
  module MetadataAdapters
    class SequelPostgres < BaseAdapter

      def valkyrie_adapter        
        @valkyrie_adapter ||= Valkyrie::Sequel::MetadataAdapter.new(
          connection: Sequel.connect(config['db'].symbolize_keys.merge(adapter: :postgres))
        )
      end

      def migrate
        valkyrie_adapter.perform_migrations!
      end
    end
  end
end

ValkyrieBenchmark::MetadataAdapters.register_metadata_adapter(ValkyrieBenchmark::MetadataAdapters::SequelPostgres)

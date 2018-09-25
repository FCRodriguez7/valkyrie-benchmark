require 'valkyrie/sequel'
module ValkyrieBenchmark
  module MetadataAdapters
    class SequelPostgres < BaseAdapter
      include ActiveRecord

      def valkyrie_adapter
        @valkyrie_adapter ||= Valkyrie::Sequel::MetadataAdapter.new(
          user: nil,
          password: nil,
          host: nil,
          port: nil,
          database: 'valkyrie_benchmark'
        )
      end

      def migrate
        valkyrie_adapter.perform_migrations!
      end

      def clean
        valkyrie_adapter.persister.wipe!
      end
    end
  end
end

ValkyrieBenchmark::MetadataAdapters.register_metadata_adapter(ValkyrieBenchmark::MetadataAdapters::SequelPostgres)

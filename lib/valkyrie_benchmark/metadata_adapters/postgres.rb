module ValkyrieBenchmark
  module MetadataAdapters
    class Postgres < BaseAdapter
      include ActiveRecord
      
      def valkyrie_adapter
        Valkyrie::Persistence::Postgres::MetadataAdapter.new
      end

      def migrations_path
        File.join(Dir.pwd,'db','migrate','postgres')
      end      
      
    end
  end
end

ValkyrieBenchmark::MetadataAdapters.register_metadata_adapter(ValkyrieBenchmark::MetadataAdapters::Postgres)

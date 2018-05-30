module ValkyrieBenchmark
  module MetadataAdapters
    class Memory < BaseAdapter
      
      def valkyrie_adapter
        Valkyrie::Persistence::Memory::MetadataAdapter.new
      end

    end
  end
end

ValkyrieBenchmark::MetadataAdapters.register_metadata_adapter(ValkyrieBenchmark::MetadataAdapters::Memory)

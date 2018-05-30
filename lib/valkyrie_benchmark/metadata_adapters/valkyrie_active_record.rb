module ValkyrieBenchmark
  module MetadataAdapters
    class ValkyrieActiveRecord < BaseAdapter
      include ActiveRecord

      def valkyrie_adapter
        Valkyrie::Persistence::ActiveRecord::MetadataAdapter.new(indexed_fields: {
          author_ids: { join: true },
          file_identifiers: { join: true }
        })
      end

    end
  end
end
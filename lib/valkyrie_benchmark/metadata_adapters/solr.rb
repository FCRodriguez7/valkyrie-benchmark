module ValkyrieBenchmark
  module MetadataAdapters
    class Solr < BaseAdapter
      
      def valkyrie_adapter
        Valkyrie::Persistence::Solr::MetadataAdapter.new(
          connection: RSolr.connect(url: config[:solr].try(:[],:url) || "http://localhost:8983/solr/valkyrie_benchmark")
        )
      end

    end
  end
end

# This disabled a warning message in generate_id
module Valkyrie::Persistence::Solr
  class Repository
    def generate_id(resource)
      resource.id = SecureRandom.uuid
    end
  end
end

ValkyrieBenchmark::MetadataAdapters.register_metadata_adapter(ValkyrieBenchmark::MetadataAdapters::Solr)

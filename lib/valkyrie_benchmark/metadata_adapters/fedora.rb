module ValkyrieBenchmark
  module MetadataAdapters
    class Fedora < BaseAdapter
      
      def valkyrie_adapter
        Valkyrie::Persistence::Fedora::MetadataAdapter.new(
          connection: ::Ldp::Client.new(config[:fedora].try(:[],:url) || "http://localhost:8984/rest"),
          base_path: config[:fedora].try(:[],:base_path) || 'valkyrie_benchmark_fedora',
          schema: Valkyrie::Persistence::Fedora::PermissiveSchema.new
        )
      end

    end
  end
end

ValkyrieBenchmark::MetadataAdapters.register_metadata_adapter(ValkyrieBenchmark::MetadataAdapters::Fedora)

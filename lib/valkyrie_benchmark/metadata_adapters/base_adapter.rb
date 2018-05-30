module ValkyrieBenchmark
  module MetadataAdapters
    class BaseAdapter

      def valkyrie_adapter
        raise('Not implemented')
      end

      def clean
        valkyrie_adapter.persister.wipe!
      end

      def enabled?
        self.class.enabled?
      end

      def config
        self.class.config
      end

      def establish_connection
      end

      def adapter_key
        self.class.adapter_key
      end

      def self.enabled?
        config['enabled'].try(:to_s).try(:downcase) != 'false'
      end

      def self.config
        @config ||= YAML.load(ERB.new(File.read(config_path)).tap do |erb| erb.filename = config_path.to_s end .result).with_indifferent_access
      end

      def self.config_path
        @config_path ||= File.join('config','metadata_adapters',self.to_s.underscore.split('/').last + '.yml')
      end

      def self.adapter_key
        self.to_s.split('::').last.underscore
      end

      def migrate
      end

    end
  end
end
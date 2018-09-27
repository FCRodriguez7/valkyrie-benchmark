module ValkyrieBenchmark
  module Tests
    class BaseTestSuite

      attr_accessor :benchmark_metadata_adapter
      attr_accessor :benchmark_group
      attr_accessor :clean_tests

      def initialize(benchmark_metadata_adapter, options={})
        self.benchmark_metadata_adapter = benchmark_metadata_adapter
        self.benchmark_group = options[:benchmark_group] || config[:benchmark_group] || (benchmark_metadata_adapter.adapter_key)
        self.clean_tests = options[:clean_tests] || false
      end

      def metadata_adapter
        @metadata_adapter ||= benchmark_metadata_adapter.valkyrie_adapter
      end

      def persister
        @persister ||= metadata_adapter.persister
      end

      def query_service
        @query_service ||= metadata_adapter.query_service
      end

      def before_test_suite
        clean!
      end

      def after_test_suite
      end

      def clean!
        benchmark_metadata_adapter.clean
      end

      def before_every_test(test)
        clean! if clean_tests?
      end

      def after_every_test(test)
      end

      def run_tests(benchmark)
        before_test_suite
        tests.each do |test|
          next unless test_enabled?(test)

          run_test(test, benchmark)
        end
        after_test_suite
      end

      def run_test(test, benchmark)
        before_every_test(test)
        self.send(:"before_#{test}") if self.respond_to?(:"before_#{test}")

        benchmark.report(benchmark_group) do
          self.send(test.to_sym)
        end

        self.send(:"after_#{test}") if self.respond_to?(:"after_#{test}")
        after_every_test(test)
      end

      def suite_name
        @suite_name ||= self.class.suite_name
      end

      def self.suite_name
        self.to_s.split('::').last.underscore.humanize
      end

      def suite_key
        @suite_key ||= self.class.suite_key
      end

      def self.suite_key
        self.to_s.split('::').last.underscore
      end      

      # Return a list of test symbols, each corresponding to a test method
      def tests
        raise "Not implemented"
      end

      def test_enabled?(test)
        config[test.to_s].try(:[],'enabled').try(:to_s).try(:downcase) != 'false'
      end

      def config
        self.class.config
      end

      def enabled?
        self.class.enabled?
      end

      def clean_tests?
        clean_tests
      end

      def self.enabled?
        config['enabled'].try(:to_s).try(:downcase) != 'false'
      end

      def self.config
        @config ||= YAML.load(ERB.new(File.read(config_path)).tap do |erb| erb.filename = config_path.to_s end .result)
      end

      def self.config_path
        @config_path ||= File.join('config','tests',self.to_s.underscore.split('/').last + '.yml')
      end
      
    end
  end
end
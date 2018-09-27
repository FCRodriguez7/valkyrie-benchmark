module ValkyrieBenchmark
  module Tests
    class AlternateIdTests < BaseTestSuite

      def suite_name
        "alternate id tests"
      end

      def before_test_suite
        @num_children = config.fetch(:num_children, 100)
        @items = []
        super
      end

      def clean!
        super
        @items = []
      end

      def tests
        [:create, :find]
      end

      def before_create
        @counter = 0
      end

      def create
        counter = @items.length
        b = ValkyrieBenchmark::Models::Book.new(title: "item",alternate_ids: ["a#{counter}","b#{counter}"])
        @items << persister.save(resource: b)
      end

      def before_find
        create while @items.length < 200
        @counter = 0
      end

      def find
        id = "#{['a','b'][@counter % 2]}#{@counter % 200}"
        @counter += 1
        @found_item = query_service.find_by_alternate_identifier(alternate_identifier: id)
      end

      def check
        raise "Didn't find items" unless @found_items.present? && @found_item.is_a?(ValkyrieBenchmark::Models::Book)
      end
      
    end
  end
end

ValkyrieBenchmark::Tests.register_test_suite(ValkyrieBenchmark::Tests::AlternateIdTests)

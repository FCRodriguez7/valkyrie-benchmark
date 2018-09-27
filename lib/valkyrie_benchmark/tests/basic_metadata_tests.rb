module ValkyrieBenchmark
  module Tests
    class BasicMetadataTests < BaseTestSuite

      def suite_name
        "basic tests"
      end

      def before_test_suite
        @stub_items = []
        @text_items = []
        @big_items = []
        @long_text = 
"""
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce non est et lorem feugiat tincidunt id et odio. Suspendisse aliquet et ante sed tincidunt. Morbi tincidunt massa pharetra, faucibus neque tempus, vestibulum nunc. Integer sollicitudin ullamcorper blandit. Vestibulum tempor hendrerit quam, ac porttitor purus semper sit amet. Donec finibus felis eget dui posuere, non iaculis turpis dignissim. Sed lorem enim, finibus interdum dui vel, tristique tristique diam. Duis volutpat vestibulum elit. Pellentesque scelerisque, velit sit amet semper venenatis, nisl nibh commodo turpis, in tempor elit libero vitae risus. Mauris urna ante, gravida eu semper vel, pharetra vel nulla. Donec dignissim iaculis tellus, et convallis tortor bibendum ac. Nulla pellentesque vehicula aliquet.

Phasellus commodo sem sit amet dolor tempor, sed venenatis odio ullamcorper. Nam tortor libero, facilisis sed est id, tristique ultrices nisi. Quisque luctus tortor et purus accumsan tempus. Integer vel varius dui. Sed posuere porta finibus. Vestibulum at lorem ultrices, dictum neque sit amet, pretium massa. Duis facilisis sagittis turpis et aliquet. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nulla id risus in erat hendrerit hendrerit.

Etiam at nunc ipsum. Morbi dui sem, efficitur in metus scelerisque, tempus elementum justo. Curabitur eget elementum lacus. Aliquam nec diam augue. In hac habitasse platea dictumst. Mauris varius congue ligula quis rutrum. Vestibulum pretium lobortis leo quis condimentum. In et congue leo, nec elementum erat. Donec placerat, ante vitae efficitur lacinia, lorem libero laoreet augue, eu congue dui nibh vitae neque. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis erat venenatis, venenatis nibh ac, elementum dui. Quisque sagittis orci nec venenatis tempus. Donec vel enim ultricies, sagittis odio ac, fringilla massa. Pellentesque nec lacus tristique, rhoncus tortor ac, maximus justo.

Nulla facilisi. Aliquam scelerisque rhoncus porta. Fusce congue viverra quam ullamcorper rhoncus. Donec eget lacinia felis, et feugiat quam. Vestibulum vel tempor nisl, sit amet consequat metus. Nullam nunc risus, fermentum eget dolor sed, fringilla aliquet metus. Sed fringilla tortor molestie tellus viverra mattis. Suspendisse sed efficitur tellus, at consequat urna. Nam malesuada dictum tellus pellentesque imperdiet. Suspendisse a posuere eros.

Donec vitae feugiat nisi, eget rutrum massa. Nullam eu blandit dui, nec fringilla tortor. Sed sollicitudin ligula a sapien semper placerat. Proin et lacus ut ligula eleifend hendrerit sed a eros. Nullam vel mauris ut felis convallis convallis eu at nisi. In porta in urna quis posuere. Cras non est erat. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam tempor sem et magna dictum tristique. Morbi eu ante cursus, cursus leo at, placerat velit. In congue dignissim metus, id malesuada ante pulvinar vel.
"""
        @num_update_items = config.fetch(:num_update_items, 100)
        @num_delete_items = config.fetch(:num_update_items, 300)

        super
      end

      def clean!
        super
        @stub_items = []
        @text_items = []
        @big_items = []
      end

      def tests
        [:create_stub,:create_with_text,:create_with_many_fields,:update_stub,:update_with_text,:update_with_many_fields,:delete_stubs,:delete_with_many_fields]
      end

      def create_stub
        p = ValkyrieBenchmark::Models::Page.new(title: "stub item")
        @stub_items << persister.save(resource: p)
      end

      def create_with_text
        p = ValkyrieBenchmark::Models::Page.new(title: "long text", text: @long_text)
        @text_items << persister.save(resource: p)
      end

      def create_with_many_fields
        b = ValkyrieBenchmark::Models::Book.new(
          title: "book",
          date: "2018-05-25",
          publisher: "Test publisher",
          keywords: ["testing", "benchmarking", "sample data", "books", "keywords", "fields", "more keywords"],
          isbn: '123456789',
          language: ["English", "Swedish"],
          format: "hardback",
          online_copy: "http://www.example.com/book",
          note: "Test note"
        )
        @big_items << persister.save(resource: b)
      end

      def before_update_stub
        create_stub while @stub_items.length < @num_update_items
        @counter = 0
      end

      def update_stub
        @update_item = @stub_items[@counter % @stub_items.length]
        @counter += 1
        @update_item.title = "stub item #{@counter}"
        @update_item = persister.save(resource: @update_item)
      end

      def before_update_with_text
        create_with_text while @text_items.length < @num_update_items
        @counter = 0
      end

      def update_with_text
        @update_item = @text_items[@counter % @text_items.length]
        @counter += 1
        @update_item.text = @long_text + " #{@counter}"
        @update_item = persister.save(resource: @update_item)
      end

      def before_update_with_many_fields
        create_with_many_fields while @big_items.length < @num_update_items
        @counter = 0
      end

      def update_with_many_fields
        @update_item = @big_items[@counter % @big_items.length]
        @counter += 1
        @update_item.title = "book #{@counter}"
        @update_item.date = "2018-05-#{(@counter % 31)+1}"
        @update_item.publisher = "Test publisher #{@counter}"
        @update_item.keywords = ["testing", "benchmarking", "sample data", "books", "keywords", "fields", "more keywords", "counter #{@counter}"],
        @update_item.isbn = "0987654321#{@counter}"
        @update_item.language = ["English", "Swedish", "German #{@counter}"]
        @update_item.format = "paperback #{@counter}"
        @update_item.online_copy = "http://www.example.com/#{@counter}"
        @update_item.note = "Note #{@counter}"
        @update_item = persister.save(resource: @update_item)
      end

      def before_delete_stubs
        create_stub while @stub_items.length < @num_delete_items
        @total_count = @stub_items.length
        @start_time = nil
        @sleep_time = nil
      end

      def delete_stubs
        @start_time ||= Time.now.to_f
        if @stub_items.empty?
          if !@sleep_time
            puts("Warning, ran out of stubs to delete. Extrapolating.")
            @sleep_time = (Time.now.to_f - @start_time) / @total_count
          end
          sleep(@sleep_time)
          return
        end
        @update_item = @stub_items.pop
        persister.delete(resource: @update_item)
      end

      def before_delete_with_many_fields
        create_with_many_fields while @big_items.length < @num_delete_items
        @total_count = @big_items.length
        @start_time = nil
        @sleep_time = nil
      end

      def delete_with_many_fields
        @start_time ||= Time.now.to_f
        if @big_items.empty?
          if !@sleep_time
            puts("Warning, ran out of big items to delete. Extrapolating.")
            @sleep_time = (Time.now.to_f - @start_time) / @total_count
          end
          sleep(@sleep_time)
          return
        end
        @update_item = @big_items.pop
        persister.delete(resource: @update_item)
      end

    end
  end
end

ValkyrieBenchmark::Tests.register_test_suite(ValkyrieBenchmark::Tests::BasicMetadataTests)

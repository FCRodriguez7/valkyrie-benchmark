module ValkyrieBenchmark
  module Tests
    class MemberTests < BaseTestSuite

      def suite_name
        "member tests"
      end

      def before_test_suite
        @num_children = config.fetch(:num_children, 100)
        @num_parents = config.fetch(:num_children, 50)
        @children = []
        @parents = []
        @unique_pages = []
        @last_page = nil
        super
      end

      def clean!
        super
        @children = []
        @parents = []
        @unique_pages = []
        @last_page = nil
      end
      

      def tests
        [:create_parent, :reload_parent, :update_child, :update_parent, :find_parents, :find_members, :one_more_page, :remove_page]
      end

      # This isn't run as a test as it's just simple resource creation. This will be tested
      # in other test suites. 
      def create_child
        @children << begin
          p = ValkyrieBenchmark::Models::Page.new(title: "page #{@children.length}")
          persister.save(resource: p)      
        end
      end

      def before_create_parent
        create_child while @children.length < @num_children
        @child_ids = @children[0..@num_children].map(&:id)
      end

      def create_parent
        @parents << begin
          b = ValkyrieBenchmark::Models::Book.new(title: "book #{@parents.length}")
          b.member_ids = @child_ids
          persister.save(resource: b)
        end
      end

      def before_reload_parent
        before_create_parent if @parents.empty?
        create_parent while @parents.length < @num_parents
        @counter = 0
      end

      def reload_parent
        parent_id = @parents[@counter % @parents.length].id
        @counter += 1
        metadata_adapter.query_service.find_by(id: parent_id)
      end

      def before_update_child
        before_create_parent if @parents.empty?
        create_parent while @parents.length < @num_parents
        @counter = 0
      end

      def update_child
        @update_child = @children[@counter % @children.length]
        @counter += 1
        @update_child.title = "Updated - #{@counter}"
        @update_child = persister.save(resource: @update_child)
      end

      def before_update_parent
        before_create_parent if @parents.empty?
        create_parent while @parents.length < @num_parents
        @counter = 0
      end

      def update_parent
        @update_parent = @parents[@counter % @parents.length]
        @counter += 1
        @update_parent.title = "Updated - #{@counter}"
        @update_parent = persister.save(resource: @update_parent)
      end

      def before_find_parents
        before_create_parent if @parents.empty?
        create_parent while @parents.length < @num_parents
        @unique_pages = (0..(@num_parents-1)).map do |i|
          # Create some pages which only belong to one parent
          @update_parent = @parents[i]
          page = ValkyrieBenchmark::Models::Page.new(title: "unique page #{i}")
          page = metadata_adapter.persister.save(resource: page)
          @update_parent.member_ids += [page.id]
          @update_parent = persister.save(resource: @update_parent)
          page
        end
        @counter = 0
      end

      def find_parents
        @queried_parents = query_service.find_parents(resource: @unique_pages[@counter % @num_parents]).to_a
        @counter += 1
      end      

      def before_one_more_page
        before_create_parent if @parents.empty?
        create_parent while @parents.length < @num_parents
        @last_page = ValkyrieBenchmark::Models::Page.new(title: 'last page')
        @last_page = metadata_adapter.persister.save(resource: @last_page)
        @counter = 0
      end

      def one_more_page
        @update_parent = @parents[@counter % @parents.length]
        @counter += 1
        @update_parent.member_ids += [@last_page.id]
        @update_parent = persister.save(resource: @update_parent)
      end

      def before_remove_page
        before_create_parent if @parents.empty?
        create_parent while @parents.length < @num_parents
        @remove_index = (@num_children / 2).to_i
        @counter = 0
      end

      def remove_page
        @update_parent = @parents[@counter % @parents.length]
        member_ids = @update_parent.member_ids
        index = [@remove_index, member_ids.length-2].min # don't remove last page
        raise 'Ran out of pages to remove' if index < 0
        @update_parent.member_ids = member_ids[0..(index-1)] + member_ids[(index+1)..-1]
        @update_parent = persister.save(resource: @update_parent)
      end

      def before_find_members
        clean! unless @parents.empty?
        before_create_parent
        create_parent while @parents.length < @num_parents
        @counter = 0
      end

      def find_members
        @update_parent = @parents[@counter % @parents.length]
        @queried_members = query_service.find_members(resource: @update_parent).to_a
      end

    end
  end
end

ValkyrieBenchmark::Tests.register_test_suite(ValkyrieBenchmark::Tests::MemberTests)

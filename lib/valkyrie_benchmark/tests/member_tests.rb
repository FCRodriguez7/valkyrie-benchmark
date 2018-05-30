module ValkyrieBenchmark
  module Tests
    class MemberTests < BaseTestSuite

      def suite_name
        "member tests"
      end

      def before_test_suite
        @num_children = config.fetch(:num_children, 100)
        @children = []
        @parents = []
        super
      end

      def tests
        [:create_parent, :reload_parent, :update_child, :update_parent, :one_more_page, :remove_page, :find_parents, :find_members]
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
        create_parent while @parents.length < 10
        @counter = 0
      end

      def reload_parent
        parent_id = @parents[@counter % @parents.length].id
        @counter += 1
        metadata_adapter.query_service.find_by(id: parent_id)
      end

      def before_update_child
        create_child while @children.length < 10
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
        create_parent while @parents.length < 10
        @counter = 0
      end

      def update_parent
        @update_parent = @parents[@counter % @parents.length]
        @counter += 1
        @update_parent.title = "Updated - #{@counter}"
        @update_parent = persister.save(resource: @update_parent)
      end

      def before_find_parents
        begin before_create_parent ; create_parent end if @parents.empty?
        @update_parent = @parents.first
        # This page is a member of only one parent
        @unique_page = ValkyrieBenchmark::Models::Page.new(title: 'unique page')
        @unique_page = metadata_adapter.persister.save(resource: @unique_page)
        @update_parent.member_ids += [@unique_page.id]
        @update_parent = persister.save(resource: @update_parent)
      end

      def find_parents
        @queried_parents = query_service.find_parents(resource: @unique_page).to_a
      end      

      def before_one_more_page
        before_create_parent if @parents.empty?
        create_parent while @parents.length < 10
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
        create_parent while @parents.length < 10
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
        # Make sure we have some parents with a predictable number of members in them
        before_create_parent if @parents.empty?
        10.times do create_parent end
        @counter = 0
      end

      def find_members
        @update_parent = @parents[-1-(@counter % 10)]
        @queried_members = query_service.find_members(resource: @update_parent).to_a
      end

      def checks
        @parent = query_service.find_by(id: @parents[0].id)
        @queried_members = query_service.find_members(resource: @parent).to_a
        raise "Parent title not updated" if @parent.title.first.start_with?('book')
        raise "Wrong parent found" unless @queried_parents.count == 1 && @queried_parents.first.id.to_s == @parent.id.to_s
        raise 'Added page not present' unless @queried_members.find do |m| m.title.first == "last page" end
        raise 'Deleted page still present' if @queried_members.find do |m| m.title.first.start_with?("page #{@remove_index}") end
      end
    end
  end
end

ValkyrieBenchmark::Tests.register_test_suite(ValkyrieBenchmark::Tests::MemberTests)

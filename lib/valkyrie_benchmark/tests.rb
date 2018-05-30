module ValkyrieBenchmark
  module Tests
    def self.register_test_suite(suite_class)
      @test_suites = ((@test_suites || []) + [suite_class]).freeze
    end
        
    def self.all
      @test_suites || []
    end
    
  end
end    

require 'valkyrie_benchmark/tests/base_test_suite'
require 'valkyrie_benchmark/tests/basic_metadata_tests'
require 'valkyrie_benchmark/tests/member_tests'
require 'valkyrie_benchmark/tests/alternate_id_tests'

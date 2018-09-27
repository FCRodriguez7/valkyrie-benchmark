module ValkyrieBenchmark
  class Runner
    attr_reader :metadata_adapters
    attr_reader :test_suites
  
    def initialize(options={})
      @metadata_adapters = options[:metadata_adapters] || ValkyrieBenchmark.enabled_metadata_adapters
      @test_suites = options[:test_suites] || ValkyrieBenchmark.enabled_test_suites
      @header_printed = false
      @benchmark_time = options[:benchmark_time] || 5.0
      @warmup_time = options[:warmup_time] || 2.0
    end
  
    def run_test_suite(test_suite_class, test_suite_options={})
      print_header unless @header_printed
      test_suites = @metadata_adapters.map do |adapter| test_suite_class.new(adapter, test_suite_options) end
  
      test_suites.each do |suite|
        connect_adapter(suite)
        suite.before_test_suite
      end

      ips_suite = IPSSuite.new(self)
  
      test_suites.first.tests.each do |test|
        puts("| %-74s |||||" % "**#{test_suite_class.suite_key} #{test}**")
        Benchmark.ips(quiet: true) do |benchmark|
          #benchmark.instance_variable_set(:@stdout, ReducedOutput.new)
          benchmark.config(suite: ips_suite)
          benchmark.time = @benchmark_time
          benchmark.warmup = @warmup_time
          test_suites.each do |suite|
            benchmark.report(ips_suite.next_item(suite, test, suite.benchmark_metadata_adapter.adapter_key)) do
              suite.send(test.to_sym)
            end
          end
          # benchmark.compare!
        end
      end

      test_suites.each do |suite|
        connect_adapter(suite)
        suite.checks if suite.respond_to?(:checks) && !suite.clean_tests?
        suite.after_test_suite
      end
  
    end

    def register_test(ips_suite, benchmark, test_suite, test, label)
    end
  
    def run_all(test_suite_options={})
      @test_suites.each do |test_suite_class|
        run_test_suite(test_suite_class, test_suite_options)
      end
    end

    def print_header
      puts("| Adapter                        |iterations/s | std.dev. |  iterations |time (s)|")
      puts("| ------------------------------ | -----------:| --------:| -----------:| ------:|")
      @header_printed = true
    end
  
    def connect_adapter(adapter_or_suite)
      if adapter_or_suite.is_a?(ValkyrieBenchmark::Tests::BaseTestSuite)
        connect_adapter(adapter_or_suite.benchmark_metadata_adapter)
      else
        unless @last_adapter == adapter_or_suite
          adapter_or_suite.establish_connection
          @last_adapter = adapter_or_suite
        end
      end
    end    
  end

  class ReducedOutput < Benchmark::IPS::Job::StdoutReport
    def start_warming(*args)
    end

    def start_running(*args)
    end

    def warming(*args)
    end

    def warmup_stats(*args)
    end

    def rjust(label)
      label = label.to_s
      if label.size > 30
        "#{label}\n#{' ' * 30}"
      else
        label.rjust(30)
      end
    end    
  end

  class IPSSuite
    # benchmark-ips calls warmup and report blocks out of order. This class gets
    # notifications when things are run and can connect the appropriate adapter.
    # Only get the provided label of the item so need a bit of a hack to reliably
    # map that to the adapter.

    def initialize(runner)
      @tests = []
      @runner = runner
    end

    def next_item(test_suite, test, label)
      @tests << [test_suite, test, false]
      "#{@tests.length - 1} - #{label}"
    end

    def test_for(label)
      @tests[label.split('-',2)[0].to_i]
    end

    def connect_adapter(label)
      @runner.connect_adapter(test_for(label)[0].benchmark_metadata_adapter)
    end

    def before_test(label)
      test_struct = test_for(label)
      return if test_struct[2]
      test_struct[2] = true
      test_suite = test_struct[0]
      test = test_struct[1]
      test_suite.send(:before_every_test, test) if test_suite.respond_to?(:before_every_test)
      test_suite.send(:"before_#{test}") if test_suite.respond_to?(:"before_#{test}")
    end

    def after_test(label)
      test_suite, test, _ = test_for(label)
      test_suite.send(:"after_#{test}") if test_suite.respond_to?(:"after_#{test}")
      test_suite.send(:after_every_test, test) if test_suite.respond_to?(:after_every_test)
    end

    def warming(label, time)
      connect_adapter(label)
      before_test(label)
    end

    def running(label, time)
      connect_adapter(label)
      # Before_test checks if it's already been run, which it will have unless warmup is disabled.
      before_test(label) 
    end

    def warmup_stats(*args)
    end

    def add_report(report, *args)
      after_test(report.header)
      label = report.header.split(' - ',2)[1]

      puts( "| %-30s | %11.3f | (±%4.1f%%) | %11d | %6.3f |" % [
        label, 
        report.iterations.to_f/report.runtime,
        report.error_percentage,
        report.iterations,
        report.runtime
      ])
    end
  end
end
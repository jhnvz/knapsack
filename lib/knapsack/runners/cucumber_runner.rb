module Knapsack
  module Runners
    class CucumberRunner
      def self.run(args)
        allocator = Knapsack::AllocatorBuilder.new(Knapsack::Adapters::CucumberAdapter).allocator

        Knapsack.logger.info
        Knapsack.logger.info "NODE #{ENV['TEST_ENV_NUMBER'] || 0}: Report features:".blue
        Knapsack.logger.info allocator.report_node_tests.blue
        Knapsack.logger.info
        Knapsack.logger.info "NODE #{ENV['TEST_ENV_NUMBER'] || 0}: Leftover features:".blue
        Knapsack.logger.info allocator.leftover_node_tests.blue
        Knapsack.logger.info

        cmd = %Q[bundle exec bin/cucumber #{args} --require #{allocator.test_dir} -- #{allocator.stringify_node_tests}]

        system(cmd)
        exit($?.exitstatus) unless $?.exitstatus == 0
      end
    end
  end
end

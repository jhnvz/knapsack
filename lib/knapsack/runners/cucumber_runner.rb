module Knapsack
  module Runners
    class CucumberRunner
      def self.run(args)
        allocator = Knapsack::AllocatorBuilder.new(Knapsack::Adapters::CucumberAdapter).allocator
        
        node_number = ENV['TEST_ENV_NUMBER']       
        
        Knapsack.logger.info
        Knapsack.logger.info "NODE #{node_number.blank? ? 0 : node_number}: Report features:".blue
        Knapsack.logger.info allocator.report_node_tests.map { |f| f.blue }
        Knapsack.logger.info
        Knapsack.logger.info "NODE #{node_number.blank? ? 0 : node_number}: Leftover features:".blue
        Knapsack.logger.info allocator.leftover_node_tests.map { |f| f.blue }
        Knapsack.logger.info

        cmd = %Q[bundle exec bin/cucumber #{args} --require #{allocator.test_dir} -- #{allocator.stringify_node_tests}]

        system(cmd)
        exit($?.exitstatus) unless $?.exitstatus == 0
      end
    end
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
 
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end
 
  config.order = "random"
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
end

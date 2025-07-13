require 'capybara/rspec'

RSpec.configure do |config|
  # Use rack_test driver by default (faster, no JS)
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  # Use selenium_headless for tests that need JavaScript
  config.before(:each, type: :system, js: true) do
    if ENV['CI']
      skip "Skipping JavaScript test in CI environment"
    else
      driven_by :selenium_chrome_headless
    end
  end
end

# Configure Capybara
Capybara.configure do |config|
  config.default_max_wait_time = 5
  config.server = :puma, { Silent: true }
end

require 'capybara/rspec'
require 'tmpdir'
require 'securerandom'

Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless=new')
  options.add_argument('--disable-gpu')
  options.add_argument('--no-sandbox')
  options.add_argument('--disable-dev-shm-usage')
  options.add_argument('--window-size=1400,900')
  user_data_dir = Dir.mktmpdir("chrome-user-data-#{SecureRandom.hex(8)}")
  options.add_argument("--user-data-dir=#{user_data_dir}")
  options.add_argument('--no-first-run')
  options.add_argument('--no-default-browser-check')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

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

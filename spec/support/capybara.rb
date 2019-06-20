Capybara.asset_host = 'http://localhost:3000'
require 'selenium-webdriver'

Capybara.register_driver :selenium do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('headless')
  options.add_argument('--window-size=1680,1050')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end
Capybara.javascript_driver = :selenium

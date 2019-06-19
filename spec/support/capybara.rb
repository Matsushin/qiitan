require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist
Capybara.server_host = Socket.ip_address_list.detect{|addr| addr.ipv4_private?}.ip_address
Capybara.server_port = 3000


Capybara.register_driver :selenium_remote do |app|
  url = "http://chrome:4444/wd/hub"
  opts = { desired_capabilities: :chrome, browser: :remote, url: url }
  driver = Capybara::Selenium::Driver.new(app, opts)
end
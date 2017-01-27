require 'rspec/expectations'
require 'selenium-webdriver'
require '../pages/cart_page'
require '../pages/item_page'
require '../pages/main_page'
#require '../app/application'

def staleness_of(element)
  element.enabled?
  false
rescue Selenium::WebDriver::Error::ObsoleteElementError
  true
end

=begin
@app = nil

RSpec.configure do |config|
  config.before(:example) do
    if @app.nil?
      @app = Application.new
    end
  end

  config.after(:suite) do
    @app.quit
  end
end
=end

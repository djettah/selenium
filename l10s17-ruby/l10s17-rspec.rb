require 'rspec'
require 'selenium-webdriver'

describe 'browser logs checker' do
  before(:each) do
    @driver = Selenium::WebDriver.for(:chrome)
    @driver.manage.timeouts.implicit_wait = 5 # seconds
    #@wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  end

  it 'should check logs at products pages' do

    # login
    url = "http://10.10.15.109/litecart/admin/?app=catalog&doc=catalog&category_id=1"
    #url = "http://localhost/litecart/admin/?app=catalog&doc=catalog&category_id=1"
    @driver.navigate.to url

    # login
    @driver.find_element(:name, 'username').send_keys "admin"
    @driver.find_element(:name, 'password').send_keys "admin"
    @driver.find_element(:name, 'login').click
    @driver.find_element(:xpath, "//div[@class='notice success']")

    # iterate products
    products = @driver.find_elements(:xpath, '//a[contains(@href,"product_id=") and (@title="Edit")]')
    products_links = products.map {|product| product.attribute("href")}

    for link in products_links do
      @driver.navigate.to link

      logs = @driver.manage.logs.get("browser")

      if logs.count > 0
        puts "INFO: Browser logs present"
        logs.each do |l|
          puts l
        end
      end

      @driver.navigate.back
    end

  end

  after(:each) do
    #sleep (5)
    @driver.quit
  end
end

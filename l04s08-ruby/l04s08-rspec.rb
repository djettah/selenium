require 'rspec'
require 'selenium-webdriver'

describe 'litecart products checker' do
  before(:each) do
    #Selenium::WebDriver::Firefox::Binary.path = "/Applications/FirefoxESR.app/Contents/MacOS/firefox"
    @driver = Selenium::WebDriver.for(:chrome)
    @driver.manage.timeouts.implicit_wait = 5 # seconds
    #@wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  end

  it 'should find products and check stickers' do

    @driver.navigate.to "http://localhost/litecart/"
    #@driver.navigate.to "http://10.10.15.109/litecart/"

    # iterate products
    products = @driver.find_elements(:xpath, '//li[contains(@class,"product")]')

    for product in products do

      #puts product.text
      #product.find_element(:xpath, './/div[contains(@class,"sticker")]')
      product.find_element(:css, 'div.sticker:only-of-type')

    end

  end

  after(:each) do
    #sleep (5)
    @driver.quit
  end
end

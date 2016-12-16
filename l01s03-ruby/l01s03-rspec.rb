require 'rspec'
require 'selenium-webdriver'

describe 'litecart admin' do
  before(:each) do
    @driver = Selenium::WebDriver.for(:firefox)
    @driver.manage.timeouts.implicit_wait = 5 # seconds
    @wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  end

  it 'should login' do

    @driver.navigate.to "http://10.10.15.109/litecart/admin/"

    @driver.find_element(:name, 'username').send_keys "admin"
    @driver.find_element(:name, 'password').send_keys "admin"
    @driver.find_element(:name, 'login').click
    @wait.until { @driver.find_element(:xpath, "//div[@class='notice success']") }

    @driver.find_element(:xpath, "//span[.='Catalog']").click
    @wait.until { @driver.find_element(:xpath, "//h1[contains(text(),'Catalog')]") }

  end

  after(:each) do
    @driver.quit
  end
end

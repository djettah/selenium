require 'rspec'
require 'selenium-webdriver'

describe 'litecart admin' do
  before(:each) do
    @driver = Selenium::WebDriver.for(:chrome)
    @driver.manage.timeouts.implicit_wait = 5 # seconds
    @wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  end

  it 'should login' do
    puts Time.now.to_i

    userName = "test#{Time.now.to_i}@mail.to"
    userPass = "1234567890"

    #@driver.navigate.to "http://10.10.15.109/litecart"
    @driver.navigate.to "http://localhost/litecart"

    @driver.find_element(:xpath, "//a[contains(@href,'create_account')]").click
    @driver.find_element(:xpath, "//input[@name='firstname']").send_keys("test")
    @driver.find_element(:xpath, "//input[@name='lastname']").send_keys("test")
    @driver.find_element(:xpath, "//input[@name='address1']").send_keys("test")
    @driver.find_element(:xpath, "//input[@name='address1']").send_keys("test")
    @driver.find_element(:xpath, "//input[@name='postcode']").send_keys("111111")
    @driver.find_element(:xpath, "//input[@name='city']").send_keys("test")
    @driver.find_element(:xpath, "//input[@name='email']").send_keys(userName)
    @driver.find_element(:xpath, "//input[@name='phone']").send_keys("1234567890")
    @driver.find_element(:xpath, "//input[@name='password']").send_keys(userPass)
    @driver.find_element(:xpath, "//input[@name='confirmed_password']").send_keys(userPass)
    @driver.find_element(:xpath, "//button[@type='submit']").click
    @driver.find_element(:xpath, "//div[@class='notice success']")

    @driver.find_element(:xpath, "//a[contains(@href,'logout')]").click

    @driver.find_element(:xpath, "//input[@name='email']").send_keys(userName)
    @driver.find_element(:xpath, "//input[@name='password']").send_keys(userPass, :enter)
    @driver.find_element(:xpath, "//div[@class='notice success']")

  end

  after(:each) do
    sleep (5)
    @driver.quit
  end
end

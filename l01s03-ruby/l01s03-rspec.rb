require 'rspec'
require 'selenium-webdriver'

describe 'litecart admin' do
  before(:each) do
    #caps = Selenium::WebDriver::Remote::Capabilities.new(:marionette => true)
    caps = Selenium::WebDriver::Remote::Capabilities.new()
    Selenium::WebDriver::Firefox::Binary.path = "/Applications/FirefoxESR.app/Contents/MacOS/firefox"
    #Selenium::WebDriver::Firefox::Binary.path = "/Applications/FirefoxNightly.app/Contents/MacOS/firefox"


    @driver = Selenium::WebDriver.for(:firefox, :desired_capabilities => caps)

    #@driver = Selenium::WebDriver.for(:firefox)
    @driver.manage.timeouts.implicit_wait = 5 # seconds

    @wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  end

  it 'should login' do

    @driver.navigate.to "http://10.10.15.109/litecart/admin/"

    @driver.find_element(:name, 'username').send_keys "admin"
    @driver.find_element(:name, 'password').send_keys "admin"
    @driver.find_element(:name, 'login').click
    @wait.until { @driver.find_element(:xpath, "//div[@class='notice success']") }

    sleep (0.5)
    @driver.find_element(:xpath, "//a[span[.='Catalog']]").click
    @wait.until { @driver.find_element(:xpath, "//h1[contains(text(),'Catalog')]") }


  end

  after(:each) do
    sleep (5)
    @driver.quit
  end
end

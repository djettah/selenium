require 'rspec'
require 'selenium-webdriver'

describe 'litecart apps checker' do
  before(:each) do
    @driver = Selenium::WebDriver.for(:chrome)
    @driver.manage.timeouts.implicit_wait = 5 # seconds
  end

  it 'should add products' do

    # login
    @driver.navigate.to "http://10.10.15.109/litecart/admin/"
    #@driver.navigate.to "http://localhost/litecart/admin/"

    # login
    @driver.find_element(:name, 'username').send_keys "admin"
    @driver.find_element(:name, 'password').send_keys "admin"
    @driver.find_element(:name, 'login').click
    @driver.find_element(:xpath, "//div[@class='notice success']")

    @driver.find_element(:xpath, "//a[span[.='Catalog']]").click

    # add product
    @driver.find_element(:xpath, "//a[contains(@href,'edit_product')]").click
    @driver.find_element(:xpath, "//input[@name='status']").click

    @driver.find_element(:xpath, "//input[contains(@name,'name')]").send_keys("Test1")

    @driver.find_element(:xpath, "//a[@href='#tab-information']").click
    @driver.find_element(:xpath, "//select[@name='manufacturer_id']").click
    @driver.find_element(:xpath, "//select[@name='manufacturer_id']/option[@value='1']").click
    @driver.find_element(:xpath, "//input[contains(@name,'short_description')]").send_keys("Test1 short description")
    @driver.find_element(:xpath, "//div[@class='trumbowyg-editor']").send_keys("Test1 description")

    @driver.find_element(:xpath, "//a[@href='#tab-prices']").click
    @driver.find_element(:xpath, "//input[@name='purchase_price']").clear
    @driver.find_element(:xpath, "//input[@name='purchase_price']").send_keys("11")
    @driver.find_element(:xpath, "//select[@name='purchase_price_currency_code']").click
    @driver.find_element(:xpath, "//select[@name='purchase_price_currency_code']/option[@value='USD']").click
    @driver.find_element(:xpath, "//input[@name='prices[USD]']").clear
    @driver.find_element(:xpath, "//input[@name='prices[USD]']").send_keys("21")

    @driver.find_element(:xpath, "//button[@name='save']").click
    @driver.find_element(:xpath, "//div[@class='notice success']")

    # validate added product
    @driver.find_element(:xpath, "//a[span[.='Catalog']]").click
    @driver.find_element(:xpath, "//a[contains(text(),'Test1')]")


  end

  after(:each) do
    #sleep (5)
    @driver.quit
  end
end

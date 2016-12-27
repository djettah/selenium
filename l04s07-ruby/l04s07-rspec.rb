require 'rspec'
require 'selenium-webdriver'

describe 'litecart apps checker' do
  before(:each) do
    #Selenium::WebDriver::Firefox::Binary.path = "/Applications/FirefoxESR.app/Contents/MacOS/firefox"
    @driver = Selenium::WebDriver.for(:chrome)
    @driver.manage.timeouts.implicit_wait = 5 # seconds
    #@wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  end

  it 'should iterate apps and check page header' do

    #@driver.navigate.to "http://10.10.15.109/litecart/admin/"
    @driver.navigate.to "http://localhost/litecart/admin/"

    @driver.find_element(:name, 'username').send_keys "admin"
    @driver.find_element(:name, 'password').send_keys "admin"
    @driver.find_element(:name, 'login').click

    @driver.find_element(:xpath, "//div[@class='notice success']")

    #sleep (0.5)

    # iterate apps
    apps = @driver.find_elements(:xpath, '//ul[@id="box-apps-menu"]/li')

    for i in 1..apps.length do
      app = @driver.find_element(:xpath, '//ul[@id="box-apps-menu"]/li[#{i.to_s}]')
      app.click

        # iterate submenus
        @driver.manage.timeouts.implicit_wait = 0
        app_docs = @driver.find_elements(:xpath, '//ul[@class="docs"]/li')
        @driver.manage.timeouts.implicit_wait = 5

        for j in 1..app_docs.length do
          app_doc = @driver.find_element(:xpath, "//ul[@class='docs']/li[#{j.to_s}]")
          puts "Checking: " + app_doc.text
          app_doc.click

          #sleep (0.5)
          @driver.find_element(:xpath, '//td[@id="content"]/h1')

        end

      #sleep (0.5)
      @driver.find_element(:xpath, '//td[@id="content"]/h1')

    end


  end

  after(:each) do
    #sleep (5)
    @driver.quit
  end
end

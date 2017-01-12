require 'rspec'
require 'selenium-webdriver'

describe 'litecart apps checker' do
  before(:each) do
    @driver = Selenium::WebDriver.for(:chrome)
    @driver.manage.timeouts.implicit_wait = 5 # seconds
    @wait = Selenium::WebDriver::Wait.new(:timeout => 5)
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

    # edit country
    @driver.find_element(:xpath, "//a[span[.='Countries']]").click
    @driver.find_element(:xpath, "//a[contains(@href,'edit_country')]").click
    links = @driver.find_elements(:xpath, "//td[@id='content']//form//a[@target='_blank']")


    main_window = @driver.window_handle

    for link in links do
      link.click
    end

    @wait.until {@driver.window_handles.count == (links.count+1)}

    all_windows = @driver.window_handles

    for window in all_windows do
      @driver.switch_to.window (window)
      if window != main_window
        @driver.close
      end
    end

  end

  after(:each) do
    #sleep (5)
    @driver.quit
  end
end

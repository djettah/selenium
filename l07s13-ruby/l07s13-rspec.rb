require 'rspec'
require 'selenium-webdriver'

describe 'litecart' do
  before(:each) do
    #@driver = Selenium::WebDriver.for(:chrome)
    #@driver = Selenium::WebDriver.for(:remote, :url => "http://10.0.20.2:4444/wd/hub", :desired_capabilities => :firefox)


    @driver = Selenium::WebDriver.for(:remote, :url =>"https://djettah:44e11d09-8ffd-403f-820b-6d74ccd4308b@ondemand.saucelabs.com:443/wd/hub", :desired_capabilities => :chrome)
    @driver.manage.timeouts.implicit_wait = 10 # seconds
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
  end

  def get_cart_quantity
    return @driver.find_element(:xpath, '//div[@id="cart"]//span[@class="quantity"]').text.to_i
  end

  def staleness_of(element)
    element.enabled?
    false
  rescue Selenium::WebDriver::Error::ObsoleteElementError
    true
  end

  it 'should add and remove ducks' do
    url = "https://demo.litecart.net/en/"
    #url = "http://10.10.15.109/litecart"
    @driver.navigate.to url

    # add ducks (not yellow)
    old_quantity = 0
    for i in 1..3 do
      #@driver.find_element(:xpath, '//li[contains(@class,"product")]').click
      @driver.find_element(:xpath, '//img[contains(@alt,"Duck") and not(@alt="Yellow Duck")]').click
      sleep (2)
      @driver.find_element(:xpath, "//button[@name='add_cart_product']").click
      sleep (2)
      @wait.until {get_cart_quantity > old_quantity}
      old_quantity = get_cart_quantity

      @driver.navigate.to url
      @driver.navigate.refresh
      sleep (3)
    end
    sleep (2)

    # go to cart
    @driver.find_element(:xpath, "//a[contains(@href,'checkout')]").click
    sleep (2)
    # empty cart
    @wait.until {@driver.find_elements(:xpath, "//button[@name='remove_cart_item']")}
    @driver.manage.timeouts.implicit_wait = 2 # seconds
    while @driver.find_elements(:xpath, "//button[@name='remove_cart_item']").count != 0
      sleep(5)
      remove = @driver.find_element(:xpath, "//button[@name='remove_cart_item']")
      remove.click
      sleep(5)
      @wait.until { staleness_of(remove) }
    end

    @driver.manage.timeouts.implicit_wait = 5 # seconds

    @driver.find_element(:xpath, "//*[contains(text(),'There are no items in your cart.')]")

  end

  after(:each) do
    #sleep (5)
    @driver.quit
  end
end

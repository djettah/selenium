class CartPage
  def initialize(driver)
    @driver = driver
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
  end

  def clear
    # empty cart
    @wait.until {@driver.find_elements(:xpath, "//button[@name='remove_cart_item']")}
    @driver.manage.timeouts.implicit_wait = 2 # seconds
    while @driver.find_elements(:xpath, "//button[@name='remove_cart_item']").count != 0
      remove = @driver.find_element(:xpath, "//button[@name='remove_cart_item']")
      remove.click
      @wait.until { staleness_of(remove) }
    end

    @driver.manage.timeouts.implicit_wait = 5 # seconds

    @driver.find_element(:xpath, "//*[contains(text(),'There are no items in your cart.')]")

    self
  end

  def quantity
    return @driver.find_element(:xpath, '//div[@id="cart"]//span[@class="quantity"]').text.to_i
  end

end
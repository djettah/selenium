class ItemPage
  def initialize(driver)
    @driver = driver
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds
  end

  def addtocart
    @driver.find_element(:xpath, "//button[@name='add_cart_product']").click
  end
end
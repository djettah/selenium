class MainPage

  def initialize(driver)
    @driver = driver
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10) # seconds

    #url = "https://demo.litecart.net/en/"
    @url = "http://localhost/litecart"
    #@url = "http://10.10.15.109/litecart"
  end

  def open
    @driver.navigate.to @url
    self
  end

  def reload
    @driver.navigate.refresh
  end

  def checkout
    # go to cart
    @driver.find_element(:xpath, "//a[contains(@href,'checkout')]").click
  end

  def getduck
    @driver.find_element(:xpath, '//img[contains(@alt,"Duck") and not(@alt="Yellow Duck")]').click
  end

end
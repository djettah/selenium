require 'selenium-webdriver'
require '../pages/cart_page'
require '../pages/item_page'
require '../pages/main_page'

class Application

  def initialize
    @driver = Selenium::WebDriver.for :chrome
    @driver.manage.timeouts.implicit_wait = 10 # seconds
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)
    #url = "https://demo.litecart.net/en/"
    @url = "http://10.10.15.109/litecart"

    @main_page = MainPage.new @driver
    @cart_page = CartPage.new @driver
    @item_page = ItemPage.new @driver

  end

  def quit
    @driver.quit
  end

  def test
    p "test ok"
  end

  def doit
    @main_page.open

    # add ducks (not yellow)
    old_quantity = 0
    for i in 1..3 do

      @main_page.getduck
      @item_page.addtocart

      @wait.until {@cart_page.quantity > old_quantity}
      old_quantity = @cart_page.quantity

      @main_page.open
      @main_page.reload

    end

    @main_page.checkout
    @cart_page.clear

  end

end



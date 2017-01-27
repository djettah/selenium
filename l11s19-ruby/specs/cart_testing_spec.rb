require './shared_setup'

describe 'Litecart' do

  before(:each) do
    @driver = Selenium::WebDriver.for :chrome
    @driver.manage.timeouts.implicit_wait = 10 # seconds
    @wait = Selenium::WebDriver::Wait.new(:timeout => 10)

    @main_page = MainPage.new @driver
    @cart_page = CartPage.new @driver
    @item_page = ItemPage.new @driver
  end

  it 'should create customer' do

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

  after(:each) do
    #sleep (5)
    @driver.quit
  end

end

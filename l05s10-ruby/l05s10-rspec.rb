require 'rspec'
require 'selenium-webdriver'

def to_float(s)
  return /\d+\.?\d*/.match(s).to_s.to_f
end

describe 'litecart products checker' do
  before(:each) do
    @driver = Selenium::WebDriver.for(:chrome)
    @driver.manage.timeouts.implicit_wait = 5 # seconds
    #@wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  end

  it 'should find products and check stickers' do

    @driver.navigate.to "http://localhost/litecart/"
    #@driver.navigate.to "http://10.10.15.109/litecart/"

    prod1 = @driver.find_element(:xpath, '//div[@id="box-campaigns"]//li[contains(@class,"product")]')
    prod1Name = prod1.find_element(:xpath, './/div[@class="name"]').text
    prod1PriceOldEl = prod1.find_element(:xpath, './/*[@class="regular-price"]')
    prod1PriceOldVal = to_float(prod1PriceOldEl.text)
    prod1PriceOldColor = prod1PriceOldEl.css_value("color")
    prod1PriceOldSize = to_float(prod1PriceOldEl.css_value("font-size"))
    prod1PriceOldWeight = prod1PriceOldEl.css_value("font-weight")
    prod1PriceOldDecor = prod1PriceOldEl.css_value("text-decoration")

    prod1PriceNewEl = prod1.find_element(:xpath, './/*[@class="campaign-price"]')
    prod1PriceNewVal = to_float(prod1PriceNewEl.text)
    prod1PriceNewSize = to_float(prod1PriceNewEl.css_value("font-size"))
    prod1PriceNewColor = prod1PriceNewEl.css_value("color")
    prod1PriceNewWeight = prod1PriceNewEl.css_value("font-weight")
    prod1PriceNewDecor = prod1PriceNewEl.css_value("text-decoration")

    if (prod1PriceOldSize >= prod1PriceNewSize) || (prod1PriceNewWeight != 'bold') || (/rgba\(\d{3}, 0, 0, 1\)/ !~ prod1PriceNewColor) ||
        /rgba\((\d{3}), \1, \1, 1\)/ !~  (prod1PriceOldColor) || (/line-through/ !~ prod1PriceOldDecor)
      fail "ERROR: Product styles mismatch"
    end

    prod1.click

    prod11 = @driver.find_element(:xpath, '//div[@id="box-product"]')
    prod11Name = prod11.find_element(:xpath, './/h1[@class="title"]').text
    prod11PriceOldEl = prod11.find_element(:xpath, './/*[@class="regular-price"]')
    prod11PriceOldVal = to_float(prod11PriceOldEl.text)
    prod11PriceOldColor = prod11PriceOldEl.css_value("color")
    prod11PriceOldSize = to_float(prod11PriceOldEl.css_value("font-size"))
    prod11PriceOldWeight = prod11PriceOldEl.css_value("font-weight")
    prod11PriceOldDecor = prod11PriceOldEl.css_value("text-decoration")

    prod11PriceNewEl = prod11.find_element(:xpath, './/*[@class="campaign-price"]')
    prod11PriceNewVal = to_float(prod11PriceNewEl.text)
    prod11PriceNewSize = to_float(prod11PriceNewEl.css_value("font-size"))
    prod11PriceNewColor = prod11PriceNewEl.css_value("color")
    prod11PriceNewWeight = prod11PriceNewEl.css_value("font-weight")
    prod11PriceNewDecor = prod11PriceNewEl.css_value("text-decoration")

    if (prod1Name != prod11Name ) || (prod1PriceOldVal != prod11PriceOldVal) || (prod1PriceNewVal != prod11PriceNewVal)
      fail "ERROR: Product data mismatch"
    end

    if (prod11PriceOldSize >= prod11PriceNewSize) || (prod11PriceNewWeight != 'bold') || (/rgba\(\d{3}, 0, 0, 1\)/ !~ prod11PriceNewColor) ||
        /rgba\((\d{3}), \1, \1, 1\)/ !~  (prod11PriceOldColor) || (/line-through/ !~ prod11PriceOldDecor)
      fail "ERROR: Product styles mismatch"
    end

  end

  after(:each) do
    #sleep (5)
    @driver.quit
  end
end

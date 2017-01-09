require 'rspec'
require 'selenium-webdriver'

describe 'litecart apps checker' do
  before(:each) do
    #Selenium::WebDriver::Firefox::Binary.path = "/Applications/FirefoxESR.app/Contents/MacOS/firefox"
    @driver = Selenium::WebDriver.for(:chrome)
    @driver.manage.timeouts.implicit_wait = 5 # seconds
    @wait = Selenium::WebDriver::Wait.new(:timeout => 5)
  end

  it 'should iterate apps and check page header' do

    # login
    #@driver.navigate.to "http://10.10.15.109/litecart/admin/"
    @driver.navigate.to "http://localhost/litecart/admin/"

    @driver.find_element(:name, 'username').send_keys "admin"
    @driver.find_element(:name, 'password').send_keys "admin"
    @driver.find_element(:name, 'login').click

    @driver.find_element(:xpath, "//div[@class='notice success']")


    # go to Countries

    @driver.find_element(:xpath, "//a[span[.='Countries']]").click
    @wait.until { @driver.find_element(:xpath, "//h1[contains(text(),'Countries')]") }

    # iterate countries

    countriesEl = @driver.find_elements(:xpath, '//table[@class="dataTable"]//td[./a/text()]')
    prevCountry = ""

    countriesText = countriesEl.map {|country| country.text()}
    countriesText.each do |country|
      if country < prevCountry
        #fail "ERROR: Values not in order: #{prevCountry}, #{country.text()}"
      end

      prevCountry = country
    end


    # iterate countries with zones

    countriesWithZonesEl = @driver.find_elements(:xpath,'//table[@class="dataTable"]//td[following-sibling::td[./text()>0]]/a')
    countriesWithZonesText = countriesWithZonesEl.map {|country| country.text()}

    countriesWithZonesText.each do |country|
      countryEl = @driver.find_element(:xpath, "//table[@class='dataTable']//td/a[text()='#{country}']")
      countryEl.click()

      zonesEl = @driver.find_elements(:xpath, '//table[@class="dataTable"]//td[./input[contains(@name,"[name]") and @type="hidden"]]')
      prevZone = ""

      zonesText = zonesEl.map {|zone| zone.text()}
      zonesText.each do |zone|
        if zone < prevZone
          #fail "ERROR: Values not in order: #{prevZone}, #{zone.text()}"
        end

        prevZone = zone
      end

      #sleep (5)
      @driver.navigate.back
    end


    # go to Geo Zones

    @driver.find_element(:xpath, "//a[span[.='Geo Zones']]").click
    @wait.until { @driver.find_element(:xpath, "//h1[contains(text(),'Geo Zones')]") }

    geoZonesEl = @driver.find_elements(:xpath, "//table[@class='dataTable']//td/a[text()]")
    geoZonesElText = geoZonesEl.map {|geozone| geozone.text()}

    geoZonesElText.each do |geozone|
      geoZoneEl = @driver.find_element(:xpath, "//table[@class='dataTable']//td/a[text()='#{geozone}']")
      geoZoneEl.click()

      zonesEl = @driver.find_elements(:xpath, '//select[contains(@name,"zone_code")]/option[@selected]')
      zonesElText = zonesEl.map {|zone| zone.text()}

      prevZone = ""
      zonesElText.each do |zone|
        if zone < prevZone
          fail "ERROR: Values not in order: #{prevZone}, #{zone.text()}"
        end

        prevZone = zone
      end

      @driver.navigate.back
    end

  end

  after(:each) do
    #sleep (5)
    @driver.quit
  end
end

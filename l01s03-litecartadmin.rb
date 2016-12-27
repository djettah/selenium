#!/usr/bin/env ruby

require "selenium-webdriver"
require 'pp'

#Selenium::WebDriver::Firefox.path = "/Applications/FirefoxESR.app/Contents/MacOS/firefox"
#driver = Selenium::WebDriver.for(:remote, :url => "http://localhost:4444/wd/hub", :desired_capabilities => :firefox)
driver = Selenium::WebDriver.for :firefox
driver.manage.timeouts.implicit_wait = 5 # seconds
wait = Selenium::WebDriver::Wait.new(:timeout => 5) # seconds

begin
	puts PP.pp(driver.capabilities)	

	driver.navigate.to "http://10.10.15.109/litecart/admin/"

	element = driver.find_element(:name, 'username')
	element.send_keys "admin"
	element = driver.find_element(:name, 'password')
	element.send_keys "admin"
	element = driver.find_element(:name, 'login')
	element.click

	wait.until { driver.find_element(:xpath, "//div[@class='notice success']") }

	element = driver.find_element(:xpath, "//span[.='Catalog']")
	element.click
		element.click

	wait.until { driver.find_element(:xpath, "//h1[contains(text(),'Catalog')]") }

rescue Exception => e
	raise
	
ensure
	driver.quit

end


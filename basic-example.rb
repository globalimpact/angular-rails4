require 'rubygems'
require "test/unit"
require 'selenium-webdriver'

class ExampleTest < Test::Unit::TestCase
    def setup
        caps = Selenium::WebDriver::Remote::Capabilities.firefox
        caps.version = "5"
        caps.platform = :XP
        caps[:name] = "Firefox Testing Selenium 2 with Ruby on Sauce"

        @driver = Selenium::WebDriver.for(
          :remote,
          :url => "http://dsmithco_github:197fbca4-bf44-46dc-b2e4-8185ed8259d5@ondemand.saucelabs.com:80/wd/hub",
          :desired_capabilities => caps)
    end

    def test_sauce
        @driver.navigate.to "http://angrails.herokuapp.com/"
        assert @driver.title.include?("AngularRails4_break")
    end

    def teardown
        @driver.quit
    end
end

class ExampleTestIE < Test::Unit::TestCase
    def setup
        caps = Selenium::WebDriver::Remote::Capabilities.ie
        caps.version = "9"
        caps.platform = :XP
        caps[:name] = "IE Testing Selenium 2 with Ruby on Sauce"

        @driver = Selenium::WebDriver.for(
          :remote,
          :url => "http://dsmithco_github:197fbca4-bf44-46dc-b2e4-8185ed8259d5@ondemand.saucelabs.com:80/wd/hub",
          :desired_capabilities => caps)
    end

    def test_sauce
        @driver.navigate.to "http://angrails.herokuapp.com/"
        assert @driver.title.include?("AngularRails4")
    end

    def teardown
        @driver.quit
    end
end
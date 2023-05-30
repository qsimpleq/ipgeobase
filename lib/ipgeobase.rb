# frozen_string_literal: true

require_relative "ipgeobase/version"

require "addressable/uri"
require "nokogiri-happymapper"
require "net/http"
require_relative "ipgeobase/ip_data"

# Lookup IP info with help of ip-api.com
module Ipgeobase
  API_ADDRESS = "http://ip-api.com/xml"

  def self.lookup(ip_address)
    uri = Addressable::URI.parse("#{API_ADDRESS}/#{ip_address}")
    http = Net::HTTP.new(uri.host, uri.port)

    response = http.get(uri.path)

    IpData.parse response.body
  end
end

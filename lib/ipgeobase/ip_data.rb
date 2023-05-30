# frozen_string_literal: true

require "nokogiri-happymapper"

module Ipgeobase
  # Ip address model mapper
  class IpData
    include HappyMapper

    tag "query"
    element :city, String
    element :country, String
    element :countryCode, String, tag: "countryCode"
    element :lat, Float
    element :lon, Float
  end
end

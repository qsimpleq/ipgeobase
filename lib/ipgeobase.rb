# frozen_string_literal: true

require_relative "ipgeobase/version"

require "addressable/uri"
require "happymapper"
require "net/http"

# Lookup IP info with help of ip-api.com
module Ipgeobase
  class Error < StandardError
  end

  def self.methodize(str)
    str = str.to_s
    str = str[1..] if str.start_with? "@"
    str.split("_")
       .each_with_index.map { |word, i| i.zero? ? word : word.capitalize }
       .join
       .to_sym
  end

  def self.api_address
    "http://ip-api.com/xml/"
  end

  def self.lookup(ip_address)
    uri = Addressable::URI.parse("#{api_address}#{ip_address}")
    http = Net::HTTP.new(uri.host, uri.port)

    response = http.get(uri.path)

    response = HappyMapper.parse response.body
    response
      .instance_variables.filter { _1.to_s.include? "_" }
      .each do |attr|
      response.define_singleton_method methodize(attr) do
        response.instance_variable_get attr
      end

      response.define_singleton_method methodize("#{attr}=") do |value|
        response.instance_variable_set attr, value
      end
    end

    response
  end
end

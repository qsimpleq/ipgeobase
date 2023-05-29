# frozen_string_literal: true

require "test_helper"

class TestIpgeobase < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_lookup
    google_ip = "8.8.8.8"
    google_xml = <<~XMLDATA
      <?xml version="1.0" encoding="UTF-8"?>
      <query>
        <status>success</status>
        <country>United States</country>
        <countryCode>US</countryCode>
        <region>VA</region>
        <regionName>Virginia</regionName>
        <city>Ashburn</city>
        <zip>20149</zip>
        <lat>39.03</lat>
        <lon>-77.5</lon>
        <timezone>America/New_York</timezone>
        <isp>Google LLC</isp>
        <org>Google Public DNS</org>
        <as>AS15169 Google LLC</as>
        <query>8.8.8.8</query>
      </query>
    XMLDATA

    uri = Addressable::URI.parse "#{Ipgeobase.api_address}#{google_ip}"

    stub_request(:get, uri)
      .to_return(status: 200, body: google_xml, headers: { content_type: "application/xml" })
    response = Ipgeobase.lookup(google_ip)

    assert response.city == "Ashburn"
    assert response.country == "United States"
    assert response.countryCode == "US"
    assert response.lat.to_s == 39.03.to_s
    assert response.lon.to_s == -77.5.to_s
  end
end

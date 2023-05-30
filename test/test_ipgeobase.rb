# frozen_string_literal: true

require "test_helper"

class TestIpgeobase < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_lookup
    google_ip = "8.8.8.8"
    google_xml = fixture_load("google.xml")
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

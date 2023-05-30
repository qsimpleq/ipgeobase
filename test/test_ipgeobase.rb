# frozen_string_literal: true

require 'test_helper'

class TestIpgeobase < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Ipgeobase::VERSION
  end

  def test_lookup
    google_ip = '8.8.8.8'
    google_xml = fixture_load('google.xml')

    stub_request(:get, "#{Ipgeobase::API_ADDRESS}/#{google_ip}")
      .to_return(status: 200, body: google_xml, headers: { content_type: 'application/xml' })
    response = Ipgeobase.lookup(google_ip)

    expected = { city: 'Ashburn', country: 'United States', countryCode: 'US', lat: 39.03, lon: -77.5 }

    expected.each_key do |key|
      assert response.send(key) == expected[key], "Wrong value: response.#{key} != #{expected[key]}"
    end
  end
end

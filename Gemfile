# frozen_string_literal: true

source "https://rubygems.org"

# Specify your gem's dependencies in ipgeobase.gemspec
gemspec

gem "addressable", "~> 2.8"
gem "nokogiri-happymapper", "~> 0.9", require: "happymapper"
gem "rake", "~> 13.0"

group :development do
  gem "rubocop", "~> 1.21"
end

group :test do
  gem "minitest", "~> 5.0"
  gem "simplecov", require: false
  gem "webmock", "~> 3.18"
end

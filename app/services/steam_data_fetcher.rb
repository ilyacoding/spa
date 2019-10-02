# frozen_string_literal: true

class SteamDataFetcher
  InvalidMarketResponse = Class.new(StandardError)

  MARKET_URL = "https://steamcommunity.com/market/priceoverview/"
  CURRENCY = "usd"

  def initialize(item, currency = CURRENCY)
    @app_id = item.app_id
    @market_hash_name = item.market_hash_name
    @currency = currency
  end

  def call
    raise InvalidMarketResponse unless hash_response[:success]

    { price: hash_response[:lowest_price][1..-1].to_d, amount: hash_response[:volume] }.with_indifferent_access
  end

  private

  attr_reader :app_id, :market_hash_name, :currency

  def hash_response
    @hash_response ||= JSON.parse(Faraday.get(MARKET_URL, params, json_headers).body).with_indifferent_access
  end

  def params
    { appid: app_id, market_hash_name: market_hash_name, currency: currency }
  end

  def json_headers
    {
      "Accept" => "application/json"
    }
  end
end

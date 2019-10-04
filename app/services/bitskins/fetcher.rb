# frozen_string_literal: true

module Bitskins
  class Fetcher
    URL = "https://bitskins.com/api/v1/get_all_item_prices/"

    class << self
      def call
        response = hash_response

        raise StandardError if response["status"] != "success"

        response["prices"]
      end

      def hash_response
        @hash_response ||= JSON.parse(Faraday.get(URL, params, json_headers).body).with_indifferent_access
      end

      def params
        { api_key: api_token, code: otp_code, app_id: app_id }
      end

      def json_headers
        {
          "Accept" => "application/json"
        }
      end

      def app_id
        730 # CSGO
      end

      def api_token
        secrets[:bitskins_api_token]
      end

      def otp_code
        ROTP::TOTP.new(otp_secret, issuer: bitskins_otp_issuer).now
      end

      def otp_secret
        secrets[:bitskins_otp_secret]
      end

      def bitskins_otp_issuer
        secrets[:bitskins_otp_issuer]
      end

      def secrets
        Rails.application.credentials
      end
    end
  end
end

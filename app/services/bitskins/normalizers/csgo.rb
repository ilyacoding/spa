# frozen_string_literal: true

module Bitskins
  module Normalizers
    class Csgo < Bitskins::Normalizers::Base
      # 1) - White - Consumer grade
      # 2) - Light blue - Industrial grade
      # 3) - Darker blue - Mil-spec
      # 4) - Purple - Restricted
      # 5) - Pinkish purple - Classified
      # 6) - Red - Covert
      # 7) - Exceedingly Rare

      DEFAULT_VALUE = "undefined"

      CSGO_COLORS_MAPPING = {
        "EB4B4B" => "Covert",
        "4B69FF" => "Mil-spec",
        "8847FF" => "Restricted",
        "D32CE6" => "Classified",
        "5E98D9" => "Industrial grade",
        "B0C3D9" => "Consumer grade",
        "E4AE39" => "Exceedingly Rare"
      }.freeze

      def call
        {
          app_id: app_id,
          market_hash_name: market_name,
          rarity: rarity,
          quality: quality,
          price: price,
          instant_sale_price: instant_sale_price
        }
      end

      private

      def app_id
        @app_id ||= raw_data["app_id"].to_i
      end

      def rarity
        @rarity ||= CSGO_COLORS_MAPPING[rarity_color].presence || DEFAULT_VALUE
      end

      def rarity_color
        @rarity_color ||= raw_data["quality_color"]
      end

      def quality
        @quality ||= /\([^()]*\)(?![^\[]*])/.match(market_name).to_s[1..-2].presence || DEFAULT_VALUE
      end

      def price
        @price ||= raw_data["price"].to_f
      end

      def instant_sale_price
        @instant_sale_price ||= raw_data["instant_sale_price"].to_f
      end

      def market_name
        @market_name ||= raw_data["market_hash_name"].presence || DEFAULT_VALUE
      end
    end
  end
end

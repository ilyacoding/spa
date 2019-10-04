# frozen_string_literal: true

module Bitskins
  class ItemData
    EmptyError = Class.new(StandardError)

    MAPPING = { 730 => Bitskins::Normalizers::Csgo }.freeze

    class << self
      def call(app_id, raw_data)
        MAPPING.fetch(app_id.to_i).new(raw_data).call
      end
    end
  end
end

# frozen_string_literal: true

module Bitskins
  class ItemPriceFetcherJob < ApplicationJob
    queue_as :low

    def perform(requested_at, raw_items_array)
      prepared_items = raw_items_array.map do |raw_item_data|
        Bitskins::ItemData.call(raw_item_data["app_id"], raw_item_data).merge(
          created_at: Time.at(requested_at).strftime("%Y-%m-%d %H-%M-%S"),
          date: Time.at(requested_at).strftime("%Y-%m-%d")
        )
      end

      ItemPrice.push_rows(prepared_items)
    end
  end
end

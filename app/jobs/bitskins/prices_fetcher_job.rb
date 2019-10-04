# frozen_string_literal: true

module Bitskins
  class PricesFetcherJob < ApplicationJob
    queue_as :high

    def perform
      items_data = Bitskins::Fetcher.call
      current_time = Time.zone.now.to_i

      items_data.in_groups_of(10, false).each do |raw_items_array|
        Bitskins::ItemPriceFetcherJob.perform_later(current_time, raw_items_array)
      end
    end
  end
end

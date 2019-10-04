# frozen_string_literal: true

module Steam
  class PricesFetcherJob < ApplicationJob
    queue_as :high

    def perform
      Item.pluck(:id).each do |item_id|
        ItemPriceFetcherJob.perform_later(item_id)
      end
    end
  end
end

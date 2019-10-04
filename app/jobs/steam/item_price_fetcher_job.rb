# frozen_string_literal: true

module Steam
  class ItemPriceFetcherJob < ApplicationJob
    queue_as :low

    def perform(id)
      item = Item.find(id)
      steam_data = SteamDataFetcher.new(item).call

      ItemPrice.create!(app_id: item.app_id, market_hash_name: item.market_hash_name, rarity: item.rarity,
                        quality: item.quality, amount: steam_data[:amount], price: steam_data[:price],
                        created_at: Time.zone.now)
      sleep 3
    end
  end
end

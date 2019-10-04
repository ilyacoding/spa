# frozen_string_literal: true

class AddIterPricesTable < Clickhouse::Rails::Migrations::Base
  def self.up
    create_table :item_prices do |t|
      t.uint16 :app_id
      t.string :market_hash_name
      t.string :rarity
      t.string :quality
      t.float64 :price
      t.float64 :instant_sale_price
      t.date :date
      t.datetime :created_at

      t.engine "MergeTree(date, (date, market_hash_name), 8192)"
    end
  end
end

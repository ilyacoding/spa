# frozen_string_literal: true

class CreateItemPrice < ActiveRecord::Migration[5.2]
  def change
    create_table :item_prices, id: false do |t|
      t.integer :app_id
      t.string :market_hash_name

      t.string :rarity
      t.string :quality
      t.integer :amount
      t.decimal :price, precision: 15, scale: 3

      t.datetime :created_at
    end
  end
end

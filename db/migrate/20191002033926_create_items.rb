class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.integer :app_id, null: false
      t.string :market_hash_name, null: false, index: { unique: true }
      t.string :rarity_color
      t.string :rarity
      t.string :quality

      t.timestamps
    end
  end
end

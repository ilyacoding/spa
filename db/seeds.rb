# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 1) - White - Consumer grade
# 2) - Light blue - Industrial grade
# 3) - Darker blue - Mil-spec
# 4) - Purple - Restricted
# 5) - Pinkish purple - Classified
# 6) - Red - Covert
# 7) - Exceedingly Rare

CSGO_COLORS_MAPPING = {
  "EB4B4B" => "Covert",
  "4B69FF" => "Mil-spec",
  "8847FF" => "Restricted",
  "D32CE6" => "Classified",
  "5E98D9" => "Industrial grade",
  "B0C3D9" => "Consumer grade",
  "E4AE39" => "Exceedingly Rare"
}.freeze

# CSGO
file = File.read(Rails.root.join("config", "items", "csgo.json"))
data = JSON.parse(file).with_indifferent_access

ActiveRecord::Base.transaction do
  data["items"].each do |item|
    next if Item.find_by(market_hash_name: item["market_hash_name"]).present?

    rarity_color = item["quality_color"]
    market_name = item["market_hash_name"]

    Item.create!(
      market_hash_name: market_name,
      app_id: item["app_id"],
      rarity_color: rarity_color,
      rarity: CSGO_COLORS_MAPPING[rarity_color],
      quality: /\([^()]*\)(?![^\[]*])/.match(market_name).to_s[1..-2]
    )
  end
end

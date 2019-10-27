# frozen_string_literal: true

# app_id
# market_hash_name
# rarity
# quality
# price
# instant_sale_price
# created_at
# date

class ItemPrice
  include Clickhouse::Table

  class << self
    def push_rows(data_rows)
      keys = data_rows.first.keys.join(", ")
      values = data_rows.map do |row|
        row.values.map do |value|
          value.is_a?(Integer) ? value : ActiveRecord::Base.connection.quote(value)
        end.join(", ")
      end

      sql_values = values.map { |raw_values| "(#{raw_values})" }.join(", ")

      Clickhouse.connection.execute("INSERT INTO #{table_name} (#{keys}) VALUES #{sql_values}")
    end

    def count
      Clickhouse.connection.execute("SELECT COUNT() FROM #{table_name}")
    end

    def last
      Clickhouse.connection.execute("SELECT * FROM #{table_name} ORDER BY created_at DESC LIMIT 1")
    end
  end
end

# frozen_string_literal: true

class ItemPrice < ActiveRecord::Base
  establish_connection "#{Rails.env}_clickhouse".to_sym
end

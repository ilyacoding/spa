# frozen_string_literal: true

module Bitskins
  module Normalizers
    class Base
      def initialize(raw_data)
        @raw_data = raw_data
      end

      def call
        raise NotImplementerError
      end

      private

      attr_reader :raw_data
    end
  end
end

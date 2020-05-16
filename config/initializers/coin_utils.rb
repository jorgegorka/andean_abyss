# frozen_string_literal: true

class CoinUtils
  class << self
    def bool_to_i(value)
      !!value ? 1 : 0
    end
  end
end

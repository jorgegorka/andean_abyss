# frozen_string_literal: true

module Spaces
  # Province - Location
  class Province < Location
    include Support

    attr_reader :terrain, :coastal

    def initialize(location_info)
      super
      @coastal = location_info[:coastal]
      @terrain = location_info[:terrain]
    end

    def highland?
      terrain == HIGHLAND
    end

    def jungle?
      terrain == JUNGLE
    end

    def lowland?
      terrain == LOWLAND
    end
  end
end

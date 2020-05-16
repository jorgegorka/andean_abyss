# frozen_string_literal: true

module Spaces
  # Locations of type city
  class City < Location
    include Support

    attr_reader :coastal

    def initialize(location_info)
      super
      @coastal = location_info[:coastal]
    end
  end
end

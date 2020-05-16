# frozen_string_literal: true

module Spaces
  # Line of Communication - Location
  class Loc < Location
    def initialize(location_info)
      super
      @economy = location_info[:economy]
      @route = location_info[:route]
      @population = 0
      @terrain = ''
    end
  end
end

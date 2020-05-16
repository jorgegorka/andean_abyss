# frozen_string_literal: true

module Spaces
  # Location base class
  class Location
    include Factions::Forces
    include Resources::Forces::HasForce
    include Control
    include Terror
    attr_reader :name, :forces, :number, :support, :country, :population, :neighbours

    def initialize(location_info)
      @name = location_info[:name]
      @number = location_info[:number]
      @country = location_info[:country] || COLOMBIA
      @population = location_info[:population]
      @neighbours = location_info[:neighbours]
      @forces = create_forces
      @control = CONTROL_NONE
      @support = SUPPORT_NEUTRAL
      @farc_zone = false
      @terror = 0
    end

    def city?
      is_a? City
    end

    def loc?
      is_a? Loc
    end

    def province?
      is_a? Province
    end

    def adjacents
      @neighbours
    end
  end
end

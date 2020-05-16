# frozen_string_literal: true

module Spaces
  # Clone a location
  class Mirror
    attr_reader :mirrored_location

    def initialize(location)
      @location = location
      @mirrored_location = cloned_location
      @mirrored_location.instance_variable_set(:@control, location.control)
      @mirrored_location.instance_variable_set(:@support, location.support)
      @mirrored_location.instance_variable_set(:@population, location.population)
      @mirrored_location.instance_variable_set(:@forces, clone_forces)
    end

    private

    attr_reader :location

    def clone_forces
      result = {}
      %i[govt farc auc cartel].each { |force| result[force] = location.forces[force].mirror }

      result
    end

    def cloned_location
      if location.city?
        City.new(find(location.number))
      elsif location.loc?
        Loc.new(find(location.number))
      else
        Province.new(find(location.number))
      end
    end

    def find(location_number)
      LOCATIONS_CONTENT.select { |location| location[:number] == location_number }.first
    end
  end
end

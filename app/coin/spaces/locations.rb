# frozen_string_literal: true

module Spaces
  # All locations available
  class Locations
    class << self
      def generate(location_content)
        all = location_content.map do |location_info|
          case location_info[:type]
          when CITY
            City.new(location_info)
          when PROVINCE
            Province.new(location_info)
          when LOC
            Loc.new(location_info)
          end
        end
        new(all)
      end
    end

    attr_reader :all

    def initialize(all)
      @all = all
    end

    def cities
      all.select(&:city?)
    end

    def provinces
      all.select(&:province?)
    end

    def locs
      all.select(&:loc?)
    end

    def populated
      @populated ||= all.select { |location| location.population.positive? }
    end

    def spaces
      @spaces ||= all.select { |location| location.city? || location.province? }
    end

    def find_adjacents(location)
      location.adjacents.map { |adjacent| find(adjacent) }.compact
    end

    def find(card_number)
      all.find { |card| card.number == card_number }
    end
  end
end

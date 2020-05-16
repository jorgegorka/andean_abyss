# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      module Terror
        # Base class for Cartel terror AI
        class Index
          MAX_TERROR_SPACES = 3

          def initialize(board)
            @board = board
          end

          def perform
            return :not_available unless can_terror?

            { action: :cartel_terror, activities: terrorise }
          end

          private

          attr_reader :board

          def can_terror?
            locations_for_terror.size.positive?
          end

          def terrorise
            locations_for_terror[0..MAX_TERROR_SPACES].map { |destination| Cartel::Terror::Space.new(destination[:location], board).perform }
          end

          def locations_for_terror
            @locations_for_terror ||= find_locations_for_terror
          end

          def find_locations_for_terror
            actions = board.locations.spaces.map do |location|
              {
                result: Cartel::Terror::Destination.new(location).check,
                location: location
              }
            end

            actions.reject { |action| action[:result] == PRIORITY_AVOID }.sort_by { |d| d[:result] }
          end
        end
      end
    end
  end
end

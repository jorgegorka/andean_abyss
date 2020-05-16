# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      module Bribe
        # Base class for Cartel bribe AI
        class Index
          MAX_BRIBE_SPACES = 3

          def initialize(board)
            @board = board
          end

          def perform
            return :not_available unless can_bribe?

            { action: :cartel_bribe, activities: perform_bribe }
          end

          private

          attr_reader :board

          def can_bribe?
            locations_for_bribe.size.positive?
          end

          def perform_bribe
            locations_for_bribe[0..MAX_BRIBE_SPACES].map { |destination| Cartel::Bribe::Space.new(destination[:location], board).perform }
          end

          def locations_for_bribe
            @locations_for_bribe ||= find_locations_for_bribe
          end

          def find_locations_for_bribe
            actions = board.locations.populated.map do |location|
              {
                result: Cartel::Bribe::Destination.new(location).check,
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

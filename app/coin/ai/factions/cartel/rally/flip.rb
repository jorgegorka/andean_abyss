# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      module Rally
        # Perform flip action when rally
        class Flip
          def initialize(location)
            @location = location
          end

          def perform
            [{
              action: :flip,
              location: location,
              results: results
            }]
          end

          private

          attr_reader :location

          def results
            total = location.cartel_active_guerrillas_total
            location.cartel_active_guerrillas.each(&:hide)

            [{ name: CARTEL_FACTION, force: GUERRILLAS, flipped: total }]
          end
        end
      end
    end
  end
end

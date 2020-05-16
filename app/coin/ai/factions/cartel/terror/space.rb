# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      module Terror
        # Cartel terror AI perform in location
        class Space
          def initialize(location, board)
            @location = location
            @board = board
          end

          def perform
            terror_operations
            result
          end

          private

          attr_reader :location, :board

          def terror_operations
            location.cartel_hidden_guerrillas.sample.activate
            location.increase_terror
            board.move_support_to(location, :neutral)
          end

          def result
            {
              action: :terror,
              location: location,
              results: [
                { name: CARTEL_FACTION, force: GUERRILLAS, hide: 1 },
                { terror: location.terror, support: location.support }
              ]
            }
          end
        end
      end
    end
  end
end

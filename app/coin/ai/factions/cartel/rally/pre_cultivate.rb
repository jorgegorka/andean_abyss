# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      module Rally
        # Perform pre cultivate action when rally
        class PreCultivate
          def initialize(location, board)
            @location = location
            @board = board
          end

          def perform
            [{
              action: :pre_cultivate,
              location: location,
              results: results
            }]
          end

          private

          attr_reader :location, :board

          def results
            board.add_forces_to(location, CARTEL_FACTION, GUERRILLAS, 1)
            [
              { name: CARTEL_FACTION, force: GUERRILLAS, added: 1 }
            ]
          end
        end
      end
    end
  end
end

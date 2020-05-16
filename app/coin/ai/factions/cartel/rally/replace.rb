# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      module Rally
        # Perform replace guerrillas with base action when rally
        class Replace
          MAX_BASES_PER_LOCATION = 2
          COST_PER_BASE = 2

          def initialize(location, board)
            @location = location
            @board = board
          end

          def perform
            [{
              action: :replace,
              location: location,
              results: results
            }]
          end

          private

          attr_reader :location, :board

          def results
            how_many = how_many_bases_removed
            board.remove_forces_from(location, CARTEL_FACTION, GUERRILLAS, how_many * COST_PER_BASE, true)
            board.add_forces_to(location, CARTEL_FACTION, BASES, how_many)
            [
              { name: CARTEL_FACTION, force: GUERRILLAS, removed: how_many * COST_PER_BASE },
              { name: CARTEL_FACTION, force: BASES, added: how_many }
            ]
          end

          def how_many_bases_removed
            total_available = MAX_BASES_PER_LOCATION - location.bases_total
            how_many = location.cartel_guerrillas_total / COST_PER_BASE
            how_many > total_available ? total_available : how_many
          end
        end
      end
    end
  end
end

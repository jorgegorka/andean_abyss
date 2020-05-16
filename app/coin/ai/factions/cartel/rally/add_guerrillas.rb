# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      module Rally
        # Perform add guerrillas action when rally
        class AddGuerrillas
          def initialize(board, location)
            @location = location
            @board = board
            @total_available = board.available_forces_for(CARTEL_FACTION, GUERRILLAS)
          end

          def perform
            return [] unless total_available.positive?

            [{
              action: :add_forces,
              location: location,
              results: results
            }]
          end

          private

          attr_reader :location, :board, :total_available

          def results
            total_needed = location.population * location.cartel_bases_total
            if total_available.positive?
              total_needed = total_available > total_needed ? total_needed : total_available
              board.add_forces_to(location, CARTEL_FACTION, GUERRILLAS, total_needed)
              [{ name: CARTEL_FACTION, force: GUERRILLAS, added: total_needed }]
            end
          end
        end
      end
    end
  end
end

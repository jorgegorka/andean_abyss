# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      module Bribe
        # Cartel bribe AI perform in location
        class Space
          def initialize(location, board)
            @location = location
            @board = board
            @results = []
          end

          def perform
            bribe_operations
            {
              action: :bribe,
              location: location,
              results: results
            }
          end

          private

          attr_reader :location, :board, :total_removed, :results

          def bribe_operations
            @total_removed = 0
            remove_govt_troops
            remove_guerrillas
            remove_bases
          end

          def remove_govt_troops
            return unless location.govt_troops_or_police?

            remove_first(location.govt_troops_total, GOVT_FACTION, TROOPS)
            remove_second(location.govt_police_total, GOVT_FACTION, POLICE)
          end

          def remove_guerrillas
            return if total_removed > 1

            remove_first(location.farc_guerrillas_total, FARC_FACTION, GUERRILLAS)
            remove_second(location.auc_guerrillas_total, AUC_FACTION, GUERRILLAS)
          end

          def remove_bases
            return unless total_removed.zero?

            remove_forces(GOVT_FACTION, BASES) && return if location.govt_bases_total.positive?
            remove_forces(FARC_FACTION, BASES) && return if location.farc_bases_total.positive?
            remove_forces(AUC_FACTION, BASES) if location.auc_bases_total.positive?
          end

          def remove_first(total, faction, force)
            return if total.zero?

            @total_removed = total > 1 ? 2 : 1
            remove_forces(faction, force, total_removed)
          end

          def remove_second(total, faction, force)
            return if total_removed > 1 || total.zero?

            to_remove = (2 - total_removed)
            to_remove = total >= to_remove ? to_remove : total
            remove_forces(faction, force, to_remove)
            @total_removed += to_remove
          end

          def remove_forces(faction, force, qty = 1)
            board.remove_forces_from(location, faction, force, qty, true)
            results.push(name: faction, force: force, remove: qty)
          end
        end
      end
    end
  end
end

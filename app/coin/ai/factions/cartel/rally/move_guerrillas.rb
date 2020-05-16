# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      module Rally
        # Perform move guerrillas action when rally
        class MoveGuerrillas
          MAX_GUERRILLAS_TO_MOVE = 3

          def initialize(origins, destination)
            @origins = origins
            @destination = destination
            @total_pending = MAX_GUERRILLAS_TO_MOVE
          end

          def perform
            @sorted_origins = origins.sort_by(&:cartel_guerrillas_total).reverse
            move_to_destination.push(destination_action)
          end

          private

          attr_reader :origins, :destination, :total_pending, :sorted_origins

          def move_to_destination
            sorted_origins.map do |sorted_origin|
              next if total_pending.zero?

              move(sorted_origin)
            end.compact
          end

          def move(origin)
            available = origin.cartel_guerrillas_total
            total_moved = available > total_pending ? total_pending : available
            @total_pending -= available
            resources = { faction: CARTEL_FACTION, force: GUERRILLAS, qty: total_moved, include_hidden: true }
            Ai::MoveForces.new(origin, destination, resources).perform
            destination.cartel_active_guerrillas.each(&:hide)
            {
              action: :move_forces,
              location: origin,
              results: [{ name: CARTEL_FACTION, force: GUERRILLAS, removed: total_moved }]
            }
          end

          def destination_action
            {
              action: :move_forces,
              location: destination,
              results: [{ name: CARTEL_FACTION, force: GUERRILLAS, added: MAX_GUERRILLAS_TO_MOVE - total_pending }]
            }
          end
        end
      end
    end
  end
end

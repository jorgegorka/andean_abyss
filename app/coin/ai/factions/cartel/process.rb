# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      # Cartel special action process
      class Process
        MAX_SHIPMENTS_TO_PLACE = 2

        def initialize(board)
          @board = board
          @available_shipments = board.resources[:shipments]
        end

        def perform
          return ACTION_NOT_AVAILABLE unless process?

          if place_shipments?
            perform_shipment
          elsif remove_base?
            perform_removal
          end
        end

        private

        attr_reader :board, :available_shipments

        def perform_shipment
          total_placed = 0
          actions = []
          while MAX_SHIPMENTS_TO_PLACE > total_placed
            locations_for_shipment[0..1].map do |location|
              board.add_shipment(location, CARTEL_FACTION)
              total_placed += 1
              actions.push(
                action: :process,
                location: location,
                results: [{ name: CARTEL_FACTION, force: GUERRILLAS, added: :shipment }]
              )
            end
          end
          actions
        end

        def perform_removal
          location = locations_for_base_removal.sample
          board.remove_forces_from(location, CARTEL_FACTION, BASES, 1)
          board.add_resources(CARTEL_FACTION, 3)
          [
            {
              action: :process,
              location: location,
              results: [{ name: CARTEL_FACTION, force: BASES, removed: 1 }, { name: CARTEL_FACTION, force: :resources, added: 3 }]
            }
          ]
        end

        def locations_for_shipment
          @locations_for_shipment = board.locations.all.select(&:cartel_guerrillas_and_bases?)
        end

        def locations_for_base_removal
          @locations_for_base_removal = board.locations.all.select { |location| location.cartel_bases_total == 2 }
        end

        def process?
          place_shipments? || remove_base?
        end

        def place_shipments?
          available_shipments.positive? && locations_for_shipment.present?
        end

        def remove_base?
          locations_for_base_removal.size.positive?
        end
      end
    end
  end
end

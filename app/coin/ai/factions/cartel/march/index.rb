# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      module March
        # Base class for Cartel march AI
        class Index
          MAX_GUERRILLAS_AND_CUBES = 3

          def initialize(board)
            @board = board
          end

          def perform
            return :not_available unless can_march?

            { action: :cartel_march, activities: march_into(destinations_for_march.first[:location]) }
          end

          private

          attr_reader :board, :special_action_available, :can_move_troops, :available, :moved, :total_cubes, :needed

          def destinations_for_march
            @destinations_for_march ||= find_destinations_for_march
          end

          def can_march?
            board.resources[:shipments].positive? && destinations_for_march.any?
          end

          def find_destinations_for_march
            actions = board.locations.spaces.map do |location|
              {
                result: Cartel::March::Destination.new(location, board.locations.find_adjacents(location)).check,
                location: location
              }
            end

            actions.reject { |action| action[:result] == PRIORITY_AVOID }.sort_by { |d| d[:result] }.reverse
          end

          def march_into(destination)
            @can_move_troops = true
            @available = 0
            @moved = 0
            @total_cubes = count_cubes(destination)
            @needed = MAX_GUERRILLAS_AND_CUBES - total_cubes
            adjacents = board.locations.find_adjacents(destination)
            adjacents = adjacents.select { |adjacent| adjacent.cartel_guerrillas_available_for_march.positive? }

            results = adjacents.map do |adjacent|
              next unless can_move_troops

              move_troops(adjacent, destination)
            end.compact

            results.push(
              action: :march,
              location: destination,
              results: [{ name: CARTEL_FACTION, force: GUERRILLAS, added: moved }]
            )

            results
          end

          def count_cubes(destination)
            destination.govt_troops_total + destination.govt_police_total
          end

          def move_troops(adjacent, destination)
            available = adjacent.cartel_guerrillas_available_for_march

            if total_cubes.positive? && needed.positive?
              available = available > needed ? needed : available
              needed -= available
              @can_move_troops = false if needed.zero?
            end
            @moved += available
            resources = { faction: CARTEL_FACTION, force: GUERRILLAS, qty: available, include_hidden: true }
            Ai::MoveForces.new(adjacent, destination, resources).perform
            if total_cubes.positive? && total_cubes + available > 3
              destination.cartel_hidden_guerrillas.each(&:activate)
            else
              destination.cartel_active_guerrillas.each(&:hide)
            end
            {
              action: :march,
              location: adjacent,
              results: [{ name: CARTEL_FACTION, force: GUERRILLAS, removed: available }]
            }
          end
        end
      end
    end
  end
end

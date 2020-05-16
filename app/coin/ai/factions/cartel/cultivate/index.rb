# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      module Cultivate
        # Cultivate special action
        class Index
          def initialize(actions, board)
            @actions = actions
            @board = board
          end

          def perform
            if can_add_base?
              add_base_to_location
            elsif can_relocate?
              relocate_base
            else
              ACTION_NOT_AVAILABLE
            end
          end

          private

          attr_reader :actions, :board, :location

          def can_add_base?
            add_base_locations.size.positive? && board.available_forces_for(CARTEL_FACTION, BASES).positive?
          end

          def can_relocate?
            board.locations.spaces.any? { |location| location.cartel_bases_total == 2 }
          end

          def add_base_to_location
            @location = add_base_locations.first[:location]
            board.add_forces_to(location, CARTEL_FACTION, BASES, 1)
            [
              {
                action: :cultivate,
                location: location,
                results: [{ name: CARTEL_FACTION, force: BASES, added: 1 }]
              }
            ]
          end

          def relocate_base
            relocation_origins = find_relocation_origins
            return if relocation_origins.size.zero?

            relocation_targets = find_relocation_targets
            return if relocation_targets.size.zero?

            move_base(relocation_origins.sample, relocation_targets.first[:location])
          end

          def find_relocation_targets
            actions = board.locations.populated.map do |location|
              {
                result: Action.new(location).check,
                location: location
              }
            end
            actions.reject { |action| action[:result] == PRIORITY_AVOID }.sort_by { |d| d[:result] }
          end

          def find_relocation_origins
            board.locations.spaces.select { |location| location.cartel_bases_total == 2 }
          end

          def add_base_locations
            @add_base_locations ||= actions.select { |action| action[:action] == :pre_cultivate }
          end

          def move_base(origin, destination)
            resources = { faction: CARTEL_FACTION, force: BASES, qty: 1 }
            Ai::MoveForces.new(origin, destination, resources).perform
            [
              {
                action: :cultivate,
                location: origin,
                results: [{ name: CARTEL_FACTION, force: BASES, removed: 1 }]
              },
              {
                action: :cultivate,
                location: destination,
                results: [{ name: CARTEL_FACTION, force: BASES, added: 1 }]
              }
            ]
          end
        end
      end
    end
  end
end

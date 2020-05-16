# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      module Rally
        # Base class for Cartel rally AI
        class Index
          def initialize(board)
            @board = board
          end

          def perform
            return :not_available if actions_for_rally.empty?

            results = perform_actions
            special_action = Cartel::Rally::SpecialAction.new(results, board).perform

            { action: :cartel_rally, activities: results + special_action }
          end

          private

          attr_reader :board, :special_action_available, :cultivate

          def actions_for_rally
            @actions_for_rally ||= find_locations_for_rally
          end

          def find_locations_for_rally
            actions = board.locations.spaces.map do |location|
              {
                result: Action.new(location).check,
                location: location
              }
            end
            actions.reject { |action| action[:result] == CARTEL_ACTION_PASS }.sort_by { |d| d[:result] }
          end

          def perform_actions
            actions_for_rally[0..2].map do |action|
              case action[:result]
              when CARTEL_ACTION_FLIP
                Cartel::Rally::Flip.new(action[:location]).perform
              when CARTEL_ACTION_ADD
                add_or_move(action[:location])
              when CARTEL_ACTION_REPLACE
                Cartel::Rally::Replace.new(action[:location], board).perform
              when CARTEL_ACTION_CULTIVATE
                Cartel::Rally::PreCultivate.new(action[:location], board).perform
              end
            end.compact.flatten
          end

          def process?
            special_action_available && !cultivate
          end

          def add_or_move(location)
            total_available = board.available_forces_for(CARTEL_FACTION, GUERRILLAS)
            if total_available.positive?
              Cartel::Rally::AddGuerrillas.new(board, location).perform
            else
              Cartel::Rally::MoveGuerrillas.new(board.locations.spaces, location).perform
            end
          end
        end
      end
    end
  end
end

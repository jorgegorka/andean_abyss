# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      module Rally
        # Perform special action after rally
        class SpecialAction
          def initialize(actions, board)
            @actions = actions
            @board = board
          end

          def perform
            result = Cartel::Cultivate::Index.new(actions, board).perform
            result = Cartel::Process.new(board).perform if result == ACTION_NOT_AVAILABLE

            result == ACTION_NOT_AVAILABLE ? [] : result
          end

          private

          attr_reader :actions, :board
        end
      end
    end
  end
end

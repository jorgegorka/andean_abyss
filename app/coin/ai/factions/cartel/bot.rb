# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      # Cartel Non-player
      class Bot
        def initialize(board)
          @board = board
        end

        def play
          action = NextAction.new(cartel_status).check

          case action
          when :rally
            Presenters::Index.new(Rally::Index.new(board).perform).format
          when :march
            Presenters::Index.new(March::Index.new(board).perform).format
          when :terror
            Presenters::Index.new(Terror::Index.new(board).perform).format
          end
        end

        private

        attr_reader :board

        def cartel_status
          # first_in_card first_next_card available_guerrilas bases_to_place available_shipments
          [
            CoinUtils.bool_to_i(board.current_card.first_faction?(CARTEL_FACTION)),
            CoinUtils.bool_to_i(board.next_card.first_faction?(CARTEL_FACTION)),
            board.available_forces_for(CARTEL_FACTION, :all),
            bases_to_place,
            board.resources[:shipments]
          ]
        end

        def bases_to_place
          board.locations.spaces.select { |location| location.cartel_guerrillas_total > 1 && location.bases_total < 2 }.size
        end
      end
    end
  end
end

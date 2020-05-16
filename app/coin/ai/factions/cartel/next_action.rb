# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      # Decission tree that calculates next move for Cartel AI
      # first elegible in current card.
      # First elegilbe in next card.
      # Guerrillas available.
      # Num. of bases a rally can place.
      # Num. of available shipments.
      class NextAction
        def initialize(status)
          @status = status
          @attributes = %w[first_in_card first_next_card available_guerrilas bases_to_place available_shipments]
          @decission_tree = DecisionTree::ID3Tree.new(
            @attributes, train_data, :rally,
            first_in_card: :continuous, first_next_card: :continuous, available_guerrilas: :continuous, bases_to_place: :continuous, available_shipments: :continuous
          )
          decission_tree.train
        end

        def check
          decission_tree.predict(status)
        end

        private

        attr_reader :status, :decission_tree

        def train_data
          [
            [1, 0, 0, 0, 0, :event],
            [1, 0, 10, 1, 1, :event],
            [0, 1, 0, 0, 0, :pass],
            [0, 1, 10, 1, 1, :pass],
            [0, 0, 10, 0, 0, :rally],
            [0, 0, 10, 0, 1, :rally],
            [0, 0, 0, 1, 0, :rally],
            [0, 0, 10, 1, 0, :rally],
            [0, 0, 9, 1, 1, :rally],
            [0, 0, 9, 0, 1, :rally],
            [0, 0, 0, 1, 1, :rally],
            [0, 0, 9, 0, 1, :march],
            [0, 0, 0, 0, 1, :march],
            [0, 0, 0, 0, 0, :terror]
          ]
        end
      end
    end
  end
end

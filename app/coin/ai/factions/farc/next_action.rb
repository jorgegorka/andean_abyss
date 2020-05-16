# frozen_string_literal: true

module Ai
  module Factions
    module Farc
      # Decission tree that calculates next move for Cartel AI
      # first elegible in current card.
      # First elegilbe in next card.
      # Guerrillas available.
      # Num. of bases a rally can place.
      # More than 3 hidden guerrillas.
      # More resources than government.
      class NextAction
        def initialize(status)
          @status = status
          @attributes = %w[first_in_card first_next_card available_guerrilas bases_to_place hidden_guerrillas more_resources]
          @decission_tree = DecisionTree::ID3Tree.new(
            @attributes, train_data, :terror,
            first_in_card: :continuous, first_next_card: :continuous, available_guerrilas: :continuous, bases_to_place: :continuous, hidden_guerrillas: :continuous, more_resources: :continuous
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
            [1, 0, 0, 0, 0, 0, :event],
            [1, 0, 10, 1, 1, 1, :event],
            [0, 1, 0, 0, 0, 0, :pass],
            [0, 1, 10, 1, 1, 1, :pass],
            [0, 0, 10, 0, 0, 0, :rally],
            [0, 0, 0, 1, 0, 0,  :rally],
            [0, 0, 9, 1, 0, 0,  :rally],
            [0, 0, 9, 0, 1, 0,  :march],
            [0, 0, 0, 0, 0, 1,  :attack],
            [0, 0, 9, 0, 0, 1,  :attack],
            [0, 0, 0, 0, 0, 0,  :terror]
          ]
        end
      end
    end
  end
end

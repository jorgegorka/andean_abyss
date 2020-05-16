# frozen_string_literal: true

module Ai
  module Factions
    module Auc
      # Decission tree that calculates next move for Cartel AI
      # first elegible in current card.
      # First elegilbe in next card.
      # Guerrillas available.
      # Num. of bases a rally can place.
      # Presence in at least half spaces where farc bases.
      # Hidden guerrillas where farc base.
      class NextAction
        def initialize(cartel_status)
          @status = cartel_status
          @attributes = %w[first_in_card first_next_card available_guerrilas bases_to_place presence_farc_bases hidden_where_farc_bases]
          @decission_tree = DecisionTree::ID3Tree.new(
            @attributes, train_data, :attack,
            first_in_card: :continuous, first_next_card: :continuous, available_guerrilas: :continuous, bases_to_place: :continuous, presence_farc_bases: :continuous, hidden_where_farc_bases: :continuous
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
            [0, 1, 0, 0, 0, 0, :pass],
            [0, 1, 7, 1, 1, 1, :pass],
            [0, 0, 7, 0, 0, 0, :rally],
            [0, 0, 6, 0, 0, 0, :attack],
            [0, 0, 0, 1, 0, 0, :rally],
            [0, 0, 0, 0, 1, 0, :march],
            [0, 0, 6, 0, 1, 0, :march],
            [0, 0, 6, 0, 0, 1, :terror],
            [0, 0, 0, 0, 0, 0, :attack]
          ]
        end
      end
    end
  end
end

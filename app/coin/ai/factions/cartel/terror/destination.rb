# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      module Terror
        # Select destination to terrorise
        class Destination
          def initialize(location)
            @location = location
            @attributes = %w[hidden_guerrilla population has_opposition has_support is_neutral]
            @decission_tree = DecisionTree::ID3Tree.new(
              @attributes, train_data, :flip,
              hidden_guerrilla: :continuous, population: :continuous, has_opposition: :continuous, has_support: :continuous, is_neutral: :continuous
            )
            decission_tree.train
          end

          def check
            decission_tree.predict(status)
          end

          private

          attr_reader :location, :decission_tree

          def train_data
            [
              [1, 1, 0, 1, 0, PRIORITY_TOP],
              [1, 3, 0, 1, 0, PRIORITY_TOP],
              [1, 1, 0, 0, 1, PRIORITY_NORMAL],
              [1, 1, 1, 0, 0, PRIORITY_LOW],
              [0, 2, 0, 0, 1, PRIORITY_AVOID],
              [0, 1, 1, 0, 0, PRIORITY_AVOID],
              [0, 1, 0, 0, 1, PRIORITY_AVOID],
              [0, 1, 1, 0, 0, PRIORITY_AVOID],
              [1, 0, 1, 0, 0, PRIORITY_AVOID]
            ]
          end

          def status
            [
              location.cartel_hidden_guerrillas_total,
              location.population,
              CoinUtils.bool_to_i(location.has_opposition?),
              CoinUtils.bool_to_i(location.has_support?),
              CoinUtils.bool_to_i(location.is_neutral?)
            ]
          end
        end
      end
    end
  end
end

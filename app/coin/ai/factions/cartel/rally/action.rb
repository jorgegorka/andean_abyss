# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      module Rally
        # Perform best action required by rally
        class Action
          def initialize(location)
            @location = location
            @attributes = %w[flip_uncover guerrillas_no_shipments cartel_bases location_bases can_cultivate]
            @decission_tree = DecisionTree::ID3Tree.new(
              @attributes, train_data, CARTEL_ACTION_FLIP,
              flip_uncover: :continuous, guerrillas_no_shipments: :continuous, cartel_bases: :continuous, location_bases: :continuous, can_cultivate: :continuous
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
              [1, 1, 1, 1, 0, CARTEL_ACTION_FLIP],
              [1, 1, 2, 2, 0, CARTEL_ACTION_FLIP],
              [0, 3, 0, 1, 0, CARTEL_ACTION_REPLACE],
              [0, 3, 1, 1, 0, CARTEL_ACTION_REPLACE],
              [0, 0, 1, 1, 0, CARTEL_ACTION_ADD],
              [0, 0, 1, 2, 0, CARTEL_ACTION_ADD],
              [0, 0, 2, 2, 0, CARTEL_ACTION_ADD],
              [0, 1, 0, 0, 1, CARTEL_ACTION_CULTIVATE],
              [0, 1, 0, 1, 1, CARTEL_ACTION_CULTIVATE],
              [0, 0, 0, 0, 0, CARTEL_ACTION_PASS]
            ]
          end

          def status
            [flip_uncover, cartel_guerrillas_with_no_shipments, cartel_bases, location_bases, can_cultivate]
          end

          def flip_uncover
            CoinUtils.bool_to_i(location.cartel_flip_guerrillas?)
          end

          def cartel_guerrillas_with_no_shipments
            location.cartel_guerrillas_with_no_shipments_total
          end

          def cartel_bases
            location.cartel_bases_total
          end

          def location_bases
            location.bases_total
          end

          def can_cultivate
            CoinUtils.bool_to_i(location.population.positive? && location.cartel_guerrillas_total > location.govt_police_total)
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      module Cultivate
        # Perform best action required by cultivate
        class Action
          def initialize(location)
            @location = location
            @attributes = %w[has_cartel_guerrillas can_have_bases more_cartel_than_police]
            @decission_tree = DecisionTree::ID3Tree.new(
              @attributes,
              train_data,
              CARTEL_ACTION_FLIP,
              has_cartel_guerrillas: :continuous, can_have_bases: :continuous, more_cartel_than_police: :continuous
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
              [1, 1, 1, PRIORITY_HIGH],
              [0, 0, 1, PRIORITY_NORMAL],
              [0, 1, 1, PRIORITY_NORMAL],
              [1, 2, 1, PRIORITY_AVOID],
              [1, 1, 0, PRIORITY_AVOID],
              [0, 2, 1, PRIORITY_AVOID],
              [0, 1, 0, PRIORITY_AVOID],
              [0, 0, 0, PRIORITY_AVOID]
            ]
          end

          def status
            [location.cartel_guerrillas_total, location.bases_total, more_cartel_than_police]
          end

          def more_cartel_than_police
            CoinUtils.bool_to_i(location.cartel_guerrillas_total >= location.govt_police_total)
          end
        end
      end
    end
  end
end

# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      module March
        # Select destinatio to march
        class Destination
          def initialize(location, adjacents)
            @location = location
            @adjacents = adjacents
            @attributes = %w[bases cartel_guerrillas_adjacent march_will_activate]
            @decission_tree = DecisionTree::ID3Tree.new(
              @attributes, train_data, :flip,
              bases: :continuous, cartel_guerrillas_adjacent: :continuous, march_will_activate: :continuous
            )
            decission_tree.train
          end

          def check
            decission_tree.predict(status)
          end

          private

          attr_reader :location, :decission_tree, :adjacents

          def train_data
            [
              [0, 2, 0, PRIORITY_TOP],
              [1, 2, 1, PRIORITY_TOP],
              [0, 1, 0, PRIORITY_NORMAL],
              [0, 2, 1, PRIORITY_NORMAL],
              [1, 2, 2, PRIORITY_NORMAL],
              [1, 1, 0, PRIORITY_AVOID],
              [2, 1, 0, PRIORITY_AVOID],
              [0, 0, 0, PRIORITY_AVOID]
            ]
          end

          def status
            [bases, cartel_guerrillas_adjacent, march_will_activate]
          end

          def cartel_guerrillas_adjacent
            adjacents.reduce(0) { |total, adjacent| total + adjacent.cartel_guerrillas_available_for_march }
          end

          def bases
            location.bases_total
          end

          def march_will_activate
            location.govt_troops_total + location.govt_police_total
          end
        end
      end
    end
  end
end

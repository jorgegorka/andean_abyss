# frozen_string_literal: true

module Ai
  module Factions
    module Cartel
      module Bribe
        # Select destination to bribe
        class Destination
          def initialize(location)
            @location = location
            @attributes = %w[cartel_troops govt_troops farc_troops auc_troops]
            @decission_tree = DecisionTree::ID3Tree.new(
              @attributes, train_data, :flip,
              cartel_troops: :continuous, govt_troops: :continuous, farc_troops: :continuous, auc_troops: :continuous
            )
            decission_tree.train
          end

          def check
            decission_tree.predict(status)
          end

          private

          attr_reader :decission_tree, :location

          def train_data
            [
              [1, 1, 0, 0, PRIORITY_TOP],
              [1, 1, 1, 1, PRIORITY_TOP],
              [1, 1, 2, 2, PRIORITY_TOP],
              [1, 0, 1, 0, PRIORITY_HIGH],
              [1, 0, 1, 1, PRIORITY_HIGH],
              [1, 0, 1, 2, PRIORITY_HIGH],
              [1, 0, 0, 1, PRIORITY_LOW],
              [1, 0, 0, 2, PRIORITY_LOW],
              [1, 0, 0, 0, PRIORITY_AVOID],
              [0, 1, 1, 1, PRIORITY_AVOID]
            ]
          end

          def status
            [
              location.cartel_forces_total,
              location.govt_forces_total,
              location.farc_forces_total,
              location.auc_forces_total
            ]
          end
        end
      end
    end
  end
end

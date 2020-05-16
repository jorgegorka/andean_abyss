# frozen_string_literal: true

module Ai
  module Factions
    module Presenters
      # Shows the outcome of the AI's turn
      class Index
        def initialize(action)
          @action = action
        end

        def format
          {
            action: action[:action],
            activities: Presenters::Activity.show(activities)
          }
        end

        private

        attr_reader :action

        def activities
          action[:activities]
        end
      end
    end
  end
end

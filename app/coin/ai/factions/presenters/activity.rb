# frozen_string_literal: true

module Ai
  module Factions
    module Presenters
      # Shows the outcome of the AI's turn
      class Activity
        class << self
          def show(activities)
            activities.map { |activity| new(activity).format }
          end
        end

        def initialize(activity)
          @activity = activity
        end

        def format
          format_location.merge format_results
        end

        private

        attr_reader :activity

        def location
          activity[:location]
        end

        def results
          activity[:results]
        end

        def format_location
          { name: location.name, control: format_control }
        end

        def format_results
          {
            actions: results.map do |result|
              { name: result[:name], force: result[:force] }.merge(action_result(result))
            end
          }
        end

        def format_control
          mirror_location = Spaces::Simulator.new(location, results).perform
          if mirror_location.control != location.control
            "Control changes to: #{mirror_location.control}"
          else
            "Control: #{location.control}"
          end
        end

        def action_result(result)
          result[:removed].present? ? { removed: result[:removed] } : { added: result[:added] }
        end
      end
    end
  end
end

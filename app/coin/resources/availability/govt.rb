# frozen_string_literal: true

module Resources
  module Availability
    # Availability of Government Forces in a location
    module Govt
      def govt_troops_or_police?
        govt_troops_total.positive? || govt_police_total.positive?
      end
    end
  end
end

# frozen_string_literal: true

module Resources
  module Availability
    # Has availability of forces in a location
    module Cartel
      def cartel_bases?
        cartel_bases.size.positive?
      end

      def cartel_guerrillas_active?
        cartel_active_guerrillas.size == cartel_guerrillas_total
      end

      def cartel_guerrillas_and_bases?
        cartel_guerrillas_total.positive? && cartel_bases_total.positive?
      end

      def cartel_guerrillas_available_for_march
        return 0 if cartel_guerrillas_total.zero?

        cartel_bases_total.positive? ? cartel_guerrillas_total - 1 : cartel_guerrillas_total
      end
    end
  end
end

# frozen_string_literal: true

module Spaces
  module Factions
    # Cartel action logic in a location
    module Cartel
      def cartel_flip_guerrillas?
        cartel_bases? && govt_troops_or_police? && cartel_guerrillas_active?
      end
    end
  end
end

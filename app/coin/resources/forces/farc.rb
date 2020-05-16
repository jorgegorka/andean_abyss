# frozen_string_literal: true

module Resources
  module Forces
    module Farc
      def farc_active_guerrillas
        forces[FARC_FACTION].active_guerrillas
      end

      def farc_hidden_guerrillas
        forces[FARC_FACTION].hidden_guerrillas
      end

      def farc_bases_total
        forces[FARC_FACTION].bases.size
      end

      def farc_bases
        forces[FARC_FACTION].bases
      end

      def farc_guerrillas
        forces[FARC_FACTION].guerrillas
      end

      def farc_shipments_total
        farc_guerrillas.reduce(0) { |total, guerrilla| total + guerrilla.shipments }
      end
    end
  end
end

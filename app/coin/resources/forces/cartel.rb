# frozen_string_literal: true

module Resources
  module Forces
    module Cartel
      def cartel_active_guerrillas
        forces[CARTEL_FACTION].active_guerrillas
      end

      def cartel_hidden_guerrillas
        forces[CARTEL_FACTION].hidden_guerrillas
      end

      def cartel_guerrillas_with_shipments_total
        forces[CARTEL_FACTION].guerrillas_with_shipment.size
      end

      def cartel_bases
        forces[CARTEL_FACTION].bases
      end

      def cartel_guerrillas
        forces[CARTEL_FACTION].guerrillas
      end

      def cartel_bases_total
        cartel_bases.size
      end

      def cartel_guerrillas_total
        cartel_active_guerrillas.size + cartel_hidden_guerrillas.size
      end

      def cartel_active_guerrillas_total
        cartel_active_guerrillas.size
      end

      def cartel_hidden_guerrillas_total
        cartel_hidden_guerrillas.size
      end

      def cartel_shipments_total
        cartel_guerrillas.reduce(0) { |total, guerrilla| total + guerrilla.shipments }
      end

      def cartel_guerrillas_with_no_shipments_total
        cartel_guerrillas_total - cartel_guerrillas_with_shipments_total
      end
    end
  end
end

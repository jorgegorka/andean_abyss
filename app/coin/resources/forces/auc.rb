# frozen_string_literal: true

module Resources
  module Forces
    module Auc
      def auc_active_guerrillas
        forces[AUC_FACTION].active_guerrillas
      end

      def auc_hidden_guerrillas
        forces[AUC_FACTION].hidden_guerrillas
      end

      def auc_bases_total
        forces[AUC_FACTION].bases.size
      end

      def auc_guerrillas
        forces[AUC_FACTION].guerrillas
      end

      def auc_bases
        forces[AUC_FACTION].bases
      end

      def auc_guerrillas_total
        auc_active_guerrillas.size + auc_hidden_guerrillas.size
      end

      def auc_shipments_total
        auc_guerrillas.reduce(0) { |total, guerrilla| total + guerrilla.shipments }
      end
    end
  end
end

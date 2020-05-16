# frozen_string_literal: true

module Resources
  module Forces
    module Total
      include Cartel
      include Auc
      include Farc
      include Govt

      def auc_forces_total
        auc_guerrillas_total + auc_bases_total
      end

      def farc_forces_total
        farc_guerrillas_total + farc_bases_total
      end

      def farc_guerrillas_total
        farc_active_guerrillas.size + farc_hidden_guerrillas.size
      end

      def farc_active_guerrillas_total
        farc_active_guerrillas.size
      end

      def farc_hidden_guerrillas_total
        farc_hidden_guerrillas.size
      end

      def cartel_forces_total
        cartel_guerrillas_total + cartel_bases_total
      end

      def active_guerrillas_total
        auc_active_guerrillas_total + farc_active_guerrillas_total + cartel_active_guerrillas_total
      end

      def govt_forces_total
        govt_police_total + govt_troops_total + govt_bases_total
      end

      def insurgents_forces_total
        auc_forces_total + farc_forces_total + cartel_forces_total
      end

      def cartel_auc_govt_forces_total
        auc_forces_total + cartel_forces_total + govt_forces_total
      end

      def bases_total
        govt_bases_total + cartel_bases_total + farc_bases_total + auc_bases_total
      end

      def forces_total
        insurgents_forces_total + govt_forces_total
      end

      def shipments_total
        cartel_shipments_total + farc_shipments_total + auc_shipments_total
      end
    end
  end
end

# frozen_string_literal: true

module Resources
  module Forces
    module Govt
      def govt_troops
        forces[GOVT_FACTION].troops
      end

      def govt_police
        forces[GOVT_FACTION].police
      end

      def govt_bases
        forces[GOVT_FACTION].bases
      end

      def govt_police_total
        govt_police
      end

      def govt_bases_total
        govt_bases.size
      end

      def govt_troops_total
        govt_troops.size
      end

      def govt_police_total
        govt_police.size
      end
    end
  end
end

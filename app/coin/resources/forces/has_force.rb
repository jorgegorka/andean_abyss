# frozen_string_literal: true

module Resources
  module Forces
    module HasForce
      include Availability::Govt
      include Availability::Cartel
      include Total

      # def insurgents?
      #   forces[:nva].any? || forces[:vc].any?
      # end

      # def cartel_troops_or_bases?
      #   cartel_troops? || cartel_bases?
      # end

      # def nva_troops?
      #   nva_troops.positive?
      # end

      # def cartel_troops?
      #   cartel_troops.positive?
      # end

      # def cartel_bases?
      #   cartel_bases.any?
      # end

      # def nva_and_cartel_troops?
      #   nva_troops? && cartel_troops?
      # end
    end
  end
end

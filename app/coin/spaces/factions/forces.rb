# frozen_string_literal: true

module Spaces
  module Factions
    # Force logic for a location
    module Forces
      include Spaces::Control
      include Spaces::Factions::Cartel

      def add_forces_to(force, resource, amount)
        forces[force].add(resource, amount)
        update_control
      end

      def remove_forces_from(force, resource, amount, hidden = false)
        forces[force].remove(resource, amount, hidden)
        update_control
      end

      def activate_guerrilla(force)
        forces[force].activate_guerrilla
      end

      private

      def create_forces
        {
          cartel: Resources::CartelForces.new,
          farc: Resources::FarcForces.new,
          auc: Resources::AucForces.new,
          govt: Resources::GovtForces.new
        }
      end
    end
  end
end

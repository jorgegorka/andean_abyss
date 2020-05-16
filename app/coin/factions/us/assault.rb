# frozen_string_literal: true

module Factions
  module Cartel
    # Assault action for US
    class Assault
      class << self
        def execute(locations)
          locations.all.map do |location|
            results = new(location).assault

            { results: results, location: location } if results.present?
          end.compact
        end
      end

      def initialize(location)
        @location = location
        @remove_forces = [
          { name: :nva, force: TROOPS, removed: 0, qty: location.nva_troops },
          { name: :nva, force: :active_guerrillas, removed: 0, qty: location.nva_active_guerrillas.size },
          { name: :vc, force: :active_guerrillas, removed: 0, qty: location.vc_active_guerrillas.size },
          { name: :nva, force: BASES, removed: 0, qty: location.nva_bases.size },
          { name: :vc, force: BASES, removed: 0, qty: location.vc_bases.size }
        ]
      end

      def assault
        return unless troops_for_assault?

        remove_insurgents(troops_modifier, 0)
      end

      private

      attr_accessor :remove_forces, :location

      def troops_modifier
        modifier = 1
        if location.province? && location.highland? && !location.cartel_bases?
          modifier =  0.5
        elsif location.cartel_bases?
          modifier =  2
        end

        (location.cartel_troops * modifier).floor
      end

      def remove_insurgents(total_to_remove, forces_index)
        while total_to_remove.positive? && location.insurgents? && forces_index < remove_forces.length
          current_force = remove_forces[forces_index]
          if current_force[:qty].positive?
            total_removed = total_to_remove > current_force[:qty] ? current_force[:qty] : total_to_remove
            current_force[:removed] = total_removed
            remove_forces[forces_index]
          end
          forces_index += 1
        end

        remove_forces
      end

      def troops_for_assault?
        location.insurgents? && location.cartel_troops?
      end
    end
  end
end

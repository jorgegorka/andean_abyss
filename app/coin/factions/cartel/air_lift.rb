# frozen_string_literal: true

module Factions
  module Cartel
    # AirLift action for US. Move troops quickly for an operation
    class AirLift
      def initialize(origin, destination, forces)
        @origin = origin
        @destination = destination
        @forces = forces
      end

      def move
        remove_from_origin
        add_to_destination
      end

      private

      attr_reader :origin, :destination, :forces

      def remove_from_origin
        forces.each { |force| origin.remove_forces(force[:name], force[:force], force[:qty]) }
      end

      def add_to_destination
        forces.each { |force| destination.add_forces_to(force[:name], force[:force], force[:qty]) }
      end
    end
  end
end

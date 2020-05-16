# frozen_string_literal: true

module Ai
  # Move forces from origin to destination
  class MoveForces
    def initialize(origin, destination, resources)
      @origin = origin
      @destination = destination
      @resources = resources
    end

    def perform
      forces = origin_force.first(resources[:qty])
      forces.each do |force|
        origin_force.delete(force)
        destination_force.push(force)
      end
    end

    private

    attr_reader :origin, :destination, :resources

    def origin_force
      origin.forces[resources[:faction]].send(resources[:force])
    end

    def destination_force
      destination.forces[resources[:faction]].send(resources[:force])
    end
  end
end

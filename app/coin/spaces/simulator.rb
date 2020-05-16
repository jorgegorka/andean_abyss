# frozen_string_literal: true

module Spaces
  # Location action simulator
  class Simulator
    def initialize(location, actions)
      @mirrored_location = Mirror.new(location).mirrored_location
      @actions = actions
    end

    def perform
      actions.each do |action|
        if action[:removed]&.positive?
          mirrored_location.remove_forces_from(action[:name], action[:force], action[:removed])
        end

        if action[:added] == :shipment
          mirrored_location.forces[action[:name]].send(action[:force]).sample.add_shipment
        elsif action[:added]&.positive?
          mirrored_location.add_forces_to(action[:name], action[:force], action[:added])
        end
      end

      mirrored_location
    end

    private

    attr_reader :actions, :mirrored_location
  end
end

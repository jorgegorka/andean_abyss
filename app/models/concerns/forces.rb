# frozen_string_literal: true

require 'active_support/concern'

module Forces
  extend ActiveSupport::Concern

  included do
    attr_reader :available_forces

    def available_forces_for(faction, force)
      if force == :all
        FORCES[faction].reduce(0) { |_total, faction_force| available_forces[faction][faction_force] }
      else
        available_forces[faction][force]
      end
    end

    def add_forces_to(location, faction, force, qty)
      added = available_forces[faction][force] > qty ? qty : available_forces[faction][force]
      available_forces[faction][force] -= added
      location.add_forces_to(faction, force, added)
    end

    def remove_forces_from(location, faction, force, qty, include_hidden = false)
      available_forces[faction][force] += qty
      location.remove_forces_from(faction, force, qty, include_hidden)
    end
  end

  class_methods do
  end
end

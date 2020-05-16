# frozen_string_literal: true

require 'active_support/concern'

module Resources
  extend ActiveSupport::Concern

  included do
    attr_reader :aid, :total_support, :oppose_bases, :oppose_bases, :total_support

    def add_resources(resource, new_amount)
      @resources[resource] += new_amount
    end

    def remove_resources(resource, new_amount)
      @resources[resource] -= new_amount
    end

    def add_shipment(location, faction)
      return unless @resources[:shipments].positive?

      remove_resources(:shipments, 1)
      location.forces[faction].guerrillas.sample.add_shipment
    end

    def move_support_to(location, support)
      location.move_support_to(support)
      update_farc_victory_mark
      update_govt_victory_mark
    end

    def update_farc_victory_mark
      opposition = locations.populated.reduce(0) { |total, location| total + location.population * opposition_modifier(location.support) }
      bases = farc_bases_total
      @oppose_bases = opposition + bases
    end

    def update_govt_victory_mark
      @total_support = locations.populated.reduce(0) { |total, location| total + location.population * support_modifier(location.support) }
    end

    private

    def opposition_modifier(support)
      return 0 if support >= SUPPORT_NEUTRAL

      (support == SUPPORT_ACTIVE_OPPOSE) ? 2 : 1
    end

    def support_modifier(support)
      return 0 if support <= SUPPORT_NEUTRAL

      (support == SUPPORT_ACTIVE) ? 2 : 1
    end
  end
end

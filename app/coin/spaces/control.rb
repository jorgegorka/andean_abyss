# frozen_string_literal: true

module Spaces
  # Control logic for a location
  module Control
    attr_reader :farc_zone, :control

    def govt_control?
      control == CONTROL_GOVT
    end

    def farc_control?
      control == CONTROL_FARC
    end

    def farc_zone_control?
      @farc_zone == CONTROL_FARC_ZONE
    end

    def update_farc_zone(zone_value)
      @farc_zone = zone_value
    end

    private

    def update_control(_set_zone = false)
      @control = if govt_forces_total > insurgents_forces_total
                   CONTROL_GOVT
                 elsif farc_forces_total > cartel_auc_govt_forces_total
                   CONTROL_FARC
                 else
                   CONTROL_NONE
                 end
    end
  end
end

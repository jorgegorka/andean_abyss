# frozen_string_literal: true

module Resources
  # Base guerrilla class
  class Guerrilla
    attr_reader :active, :shipments

    def initialize(is_active = false, shipments = 0)
      @shipments = shipments
      @active = is_active
    end

    def activate
      @active = true
    end

    def hide
      @active = false
    end

    def add_shipment
      @shipments += 1
    end

    def remove_shipment
      @shipments -= 1
    end
  end
end

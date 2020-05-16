# frozen_string_literal: true

module Resources
  # Insurgent forces module
  class Insurgents
    attr_reader BASES, GUERRILLAS

    def initialize
      @guerrillas = []
      @bases = []
    end

    def activate_guerrilla
      return unless hidden_guerrillas.size.positive?

      hidden_guerrillas.first.activate
    end

    def clone_guerrilla(is_active, shipments)
      @guerrillas.push Resources::Guerrilla.new(is_active, shipments)
    end

    def hide_guerrilla
      return unless active_guerrillas.size.positive?

      active_guerrillas.first.hide
    end

    def active_guerrillas
      @guerrillas.select(&:active)
    end

    def hidden_guerrillas
      @guerrillas.reject(&:active)
    end

    def guerrillas_with_shipment
      @guerrillas.select { |guerrilla| guerrilla.shipments.positive? }
    end

    def add(resource, amount = 1)
      case resource
      when GUERRILLAS
        add_guerrillas(amount)
      when BASES
        add_bases(amount)
      end
    end

    def remove(resource, amount = 1, hidden = false)
      case resource
      when GUERRILLAS
        remove_guerrillas(amount, hidden)
      when BASES
        remove_bases(amount)
      end
    end

    def mirror
      copy = Resources::Insurgents.new
      @guerrillas.each { |guerrilla| copy.clone_guerrilla(guerrilla.active, guerrilla.shipments) }
      copy.add(BASES, bases.size)

      copy
    end

    private

    def add_bases(new_amount)
      new_amount.times { @bases.push(Base.new) }
    end

    def add_guerrillas(new_amount)
      new_amount.times { @guerrillas.push(Guerrilla.new) }
    end

    def remove_bases(new_amount)
      new_amount.times { @bases.pop }
    end

    def remove_guerrillas(new_amount, hidden = false)
      if hidden
        if active_guerrillas.size >= new_amount
          remove_active_guerrillas(new_amount)
        else
          remove_hidden = new_amount - active_guerrillas.size
          remove_active_guerrillas(active_guerrillas.size)
          remove_hidden_guerrillas(remove_hidden)
        end
      else
        remove_active_guerrillas(new_amount)
      end
    end

    def remove_active_guerrillas(new_amount)
      new_active = active_guerrillas
      new_amount.times { new_active.pop }
      @guerrillas = hidden_guerrillas + new_active
    end

    def remove_hidden_guerrillas(new_amount)
      new_hidden = hidden_guerrillas
      new_amount.times { new_hidden.pop }
      @guerrillas = active_guerrillas + new_hidden
    end
  end
end

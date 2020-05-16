# frozen_string_literal: true

module Resources
  # Government resources
  class GovtForces
    attr_accessor TROOPS, POLICE, BASES, :available_troops, :available_police, :available_bases

    def initialize
      @troops = []
      @police = []
      @bases = []
    end

    def add(resource, amount = 1)
      case resource
      when TROOPS
        add_troops(amount)
      when POLICE
        add_police(amount)
      when BASES
        add_bases(amount)
      end
    end

    def remove(resource, amount = 1, _include_hidden = false)
      case resource
      when TROOPS
        remove_troops(amount)
      when POLICE
        remove_police(amount)
      when BASES
        remove_bases(amount)
      end
    end

    def mirror
      copy = Resources::GovtForces.new
      copy.add(TROOPS, troops.size)
      copy.add(POLICE, police.size)
      copy.add(BASES, bases.size)

      copy
    end

    def govt_troops
      forces[GOVT_FACTION].troops
    end

    def govt_police
      forces[GOVT_FACTION].police
    end

    def govt_bases
      forces[GOVT_FACTION].bases
    end

    private

    def add_bases(new_amount)
      new_amount.times { @bases.push(Base.new) }
    end

    def remove_bases(new_amount)
      new_amount.times { @bases.pop }
    end

    def add_troops(new_amount)
      new_amount.times { @troops.push(Base.new) }
    end

    def remove_troops(new_amount)
      new_amount.times { @troops.pop }
    end

    def add_police(new_amount)
      new_amount.times { @police.push(Base.new) }
    end

    def remove_police(new_amount)
      new_amount.times { @police.pop }
    end
  end
end

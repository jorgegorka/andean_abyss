# frozen_string_literal: true

def add_forces_to_location(location, forces = [])
  forces = %i[govt farc] if forces.blank?

  if forces.include? GOVT_FACTION
    location.forces[GOVT_FACTION].add(TROOPS, 2)
    location.forces[GOVT_FACTION].add(BASES, 1)
  end

  if forces.include? FARC_FACTION
    location.forces[FARC_FACTION].add(GUERRILLAS, 2)
    location.forces[FARC_FACTION].activate_guerrilla
    location.forces[FARC_FACTION].add(BASES, 1)
  end
end

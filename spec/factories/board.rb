# frozen_string_literal: true

FactoryBot.define do
  factory :board do
    factory :standard_board do
      after(:build) do |board|
        board.add_forces_to(GOVT_FACTION, TROOPS, 30)
        board.add_forces_to(GOVT_FACTION, POLICE, 30)
        board.add_forces_to(GOVT_FACTION, BASES, 3)
        board.add_forces_to(FARC_FACTION, GUERRILLAS, 30)
        board.add_forces_to(FARC_FACTION, BASES, 9)
        board.add_forces_to(AUC_FACTION, GUERRILLAS, 18)
        board.add_forces_to(AUC_FACTION, BASES, 6)
        board.add_forces_to(CARTEL_FACTION, GUERRILLAS, 12)
        board.add_forces_to(CARTEL_FACTION, BASES, 15)
      end
    end
  end
end

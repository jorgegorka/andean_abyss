# frozen_string_literal: true

FactoryBot.define do
  factory :loc, class: 'Spaces::Loc' do
    type { LOC }
    sequence(:number)
    name { 'Cali - Buenaventura' }
    economy { 1 }
    population { 0 }

    initialize_with { new(attributes) }
  end
end

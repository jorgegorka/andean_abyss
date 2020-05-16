# frozen_string_literal: true

FactoryBot.define do
  factory :city, class: 'Spaces::City' do
    type { CITY }
    sequence(:number)
    name { 'Bogotá & Villavicencio' }
    population { 8 }
    neighbours { [14, 20, 21, 13] }
    coastal { false }

    initialize_with { new(attributes) }
  end
end

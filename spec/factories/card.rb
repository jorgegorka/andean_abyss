# frozen_string_literal: true

FactoryBot.define do
  factory :card do
    number { 2 }
    name { 'Ospina & Mora' }
    capability { CAPABILITY_GOVT }
    order { 'GFAC' }
    propaganda { false }

    initialize_with { new(attributes) }

    factory :propaganda_card do
      propaganda { true }
    end
  end
end

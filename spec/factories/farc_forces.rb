# frozen_string_literal: true

FactoryBot.define do
  factory :farc_forces, class: 'Resources::FarcForces' do
    active_guerrillas { 2 }
    hidden_guerrillas { 3 }
    bases { 1 }

    initialize_with { new(attributes) }
  end
end

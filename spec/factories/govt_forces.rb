# frozen_string_literal: true

FactoryBot.define do
  factory :govt_forces, class: 'Resources::GovtForces' do
    hidden_guerrillas { 2 }
    bases { 1 }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :province, class: 'Spaces::Province' do
    type { PROVINCE }
    sequence(:number)
    name { 'Nariño - Cauca' }
    population { 1 }
    terrain { FOREST }
    neighbours { [18, 13, 23, 47] }
    coastal { true }

    initialize_with { new(attributes) }

    factory :profile_with_passive_oppose do
      after(:build, &:decrease_support)
    end

    factory :with_active_oppose do
      after(:build) { |province| 2.times { province.decrease_support } }
    end
  end
end

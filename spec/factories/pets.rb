FactoryBot.define do
  factory :pet do
    tracker_type { 'big' }
    owner_id { 123 }
    in_zone { true }
  end

  factory :dog, parent: :pet, class: 'Dog' do
  end

  factory :cat, parent: :pet, class: 'Cat' do
    lost_tracker { false }
  end
end

FactoryGirl.define do
  factory :unit do
    sequence(:name) { |i| "Unit #{i}" }

    school
  end
end

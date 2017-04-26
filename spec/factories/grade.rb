FactoryGirl.define do
  factory :grade do
    sequence(:name) { |i| "Grade #{i}" }

    level
    unit
  end
end

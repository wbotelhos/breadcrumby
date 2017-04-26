FactoryGirl.define do
  factory :level do
    sequence(:name) { |i| "Level #{i}" }

    course
  end
end

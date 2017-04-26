FactoryGirl.define do
  factory :school do
    sequence(:name) { |i| "School #{i}" }
  end
end

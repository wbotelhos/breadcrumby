# frozen_string_literal: true

FactoryGirl.define do
  factory :school do
    sequence(:name) { |i| "School #{i}" }
  end
end

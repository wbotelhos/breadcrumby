# frozen_string_literal: true

FactoryGirl.define do
  factory :level do
    sequence(:name) { |i| "Level #{i}" }

    course
  end
end

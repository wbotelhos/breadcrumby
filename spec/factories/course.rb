# frozen_string_literal: true

FactoryGirl.define do
  factory :course do
    sequence(:name) { |i| "Course #{i}" }

    school
  end
end

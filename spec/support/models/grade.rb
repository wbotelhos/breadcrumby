# frozen_string_literal: true

class Grade < ::ActiveRecord::Base
  belongs_to :level
  belongs_to :unit
end

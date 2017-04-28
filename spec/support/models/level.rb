# frozen_string_literal: true

class Level < ::ActiveRecord::Base
  belongs_to :course
end

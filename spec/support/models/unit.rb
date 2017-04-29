# frozen_string_literal: true

class Unit < ::ActiveRecord::Base
  belongs_to :school

  def index_path
    "#{self.class.name.underscore}.index.path"
  end

  def show_path
    "#{self.class.name.underscore}.show.path"
  end
end

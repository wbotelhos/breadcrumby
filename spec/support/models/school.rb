# frozen_string_literal: true

class School < ::ActiveRecord::Base
  breadcrumby

  def custom_method_name
    :custom_method_name
  end

  def custom_method_name_nil; end

  def show_path
    "#{self.class.name.underscore}.show.path"
  end
end

class Unit < ::ActiveRecord::Base
  belongs_to :school

  def show_path
    "#{self.class.name.underscore}.path"
  end
end

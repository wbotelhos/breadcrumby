# frozen_string_literal: true

require 'breadcrumby/helpers/view_helper'

module Breadcrumby
  module Rails
    class Engine < ::Rails::Engine
      initializer 'breadcrumby.include_view_helper' do |_app|
        ActiveSupport.on_load :action_view do
          include ViewHelper
        end
      end
    end
  end
end

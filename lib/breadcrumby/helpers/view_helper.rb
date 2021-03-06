# frozen_string_literal: true

module Breadcrumby
  module ViewHelper
    def breadcrumby(object, options = {})
      Viewer.new(object, options, self).breadcrumb
    end
  end
end

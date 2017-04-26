# frozen_string_literal: true

module Breadcrumby
end

require 'breadcrumby/engine'
require 'breadcrumby/models/extension'
require 'breadcrumby/models/home'
require 'breadcrumby/models/viewer'

ActiveRecord::Base.include Breadcrumby::Extension

# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'

require 'active_record/railtie'
require 'breadcrumby'
require 'pry-byebug'

ActiveRecord::Base.establish_connection adapter: :sqlite3, database: ':memory:'

Dir[File.expand_path('support/**/*.rb', __dir__)].each { |file| require file }

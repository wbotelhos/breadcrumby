# frozen_string_literal: true

module Breadcrumby
  module Extension
    extend ActiveSupport::Concern

    included do
      def breadcrumby
        path_option = breadcrumby_options[:path]

        if !path_option.is_a?(Array) || path_option.blank?
          path_option = [path_option].flatten.compact
        end

        extracting self, path_option.reverse, [self]
      end

      def breadcrumby_options
        self.class.breadcrumby_options
      end

      private

      def extracting(object, models, objects)
        if models.present?
          models.each.with_index do |model, index|
            if model.is_a? Array
              object = send(model.last)

              if model.size == 1
                objects += object.breadcrumby
              else
                objects << object

                extracting object, model.reverse.drop(1), objects
              end
            elsif !model.nil?
              object = object.send(model)

              if models.size - 1 == index
                objects += object.breadcrumby
              else
                objects << object
              end
            end
          end
        end

        objects
      end
    end

    module ClassMethods
      def breadcrumby(options = {})
        @options = options.reverse_merge({
          i18n_key:    self.name.underscore,
          method_name: :name
        })
      end

      def breadcrumby_options
        @options || {}
      end
    end
  end
end

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

      def extract(models, index, object, objects)
        if last_item?(models, index)
          objects += object.breadcrumby
        else
          objects << object
        end

        objects
      end

      def extracting(object, models, objects)
        return objects if models.blank?

        models.each.with_index do |model, index|
          if model.is_a? Array
            object  = send(model.last)
            index   = 0
            objects = extract(model, index, object, objects)

            unless last_item?(model, index)
              extracting object, model.reverse.drop(1), objects
            end
          elsif !model.nil?
            object  = object.send(model)
            objects = extract(models, index, object, objects)
          end
        end

        objects
      end

      def last_item?(collection, index)
        collection.size - 1 == index
      end
    end

    module ClassMethods
      def breadcrumby(options = {})
        @options = options.reverse_merge(
          i18n_key:    name.underscore,
          method_name: :name
        )
      end

      def breadcrumby_options
        @options || {}
      end
    end
  end
end

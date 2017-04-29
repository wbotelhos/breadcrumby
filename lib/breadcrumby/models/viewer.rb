# frozen_string_literal: true

module Breadcrumby
  class Viewer
    def initialize(object, options = {}, view = ActionController::Base.helpers)
      @object  = object
      @options = options
      @view    = view
    end

    def breadcrumb
      return '' unless @object.respond_to?(:breadcrumby)

      action = @options[:action]

      list = breadcrumbs(current_object).map.with_index do |object, index|
        item link(object) + meta(index + 1)
      end

      if action.present?
        list.unshift item(link(current_object, action: action) + meta(list.size + 1))
      end

      list = list.reverse.join('').html_safe

      @view.content_tag :ol, list, list_options
    end

    def breadcrumbs(object, crumbs: [])
      items = object.breadcrumby

      items += [crumbs].flatten if crumbs.present?

      @breadcrumbs ||= items.append(Breadcrumby::Home.new(@view))
    end

    def current_object
      @current_object ||= begin
        return @object if object_action.blank?

        if object_action.respond_to?(:call)
          object_action.call @view
        else
          object_action
        end
      end
    end

    def i18n_action_name(object, action)
      label = "actions.#{action}.name"

      I18n.t(label, scope: scope(object), default:
        I18n.t(label, scope: scope(object, include_model: false), default:
          I18n.t(action)))
    end

    def i18n_name(object)
      I18n.t(:name,
             scope:   scope(object),
             default: object.send(object.breadcrumby_options[:method_name]) || '--')
    end

    def item(content, options = item_options)
      @view.content_tag :li, content, options
    end

    def item_options
      {
        itemprop:  :itemListElement,
        itemscope: true,
        itemtype:  'http://schema.org/ListItem'
      }
    end

    def link(object, action: nil)
      @view.link_to(
        link_tag_name(object, action),
        link_action(object, action),
        link_options(object, action)
      )
    end

    def link_action(object, action)
      action ? 'javascript:void(0);' : object.show_path
    end

    def link_options(object, action)
      name       = i18n_name(object)
      title_path = action ? "actions.#{action}.title" : :title
      title      = I18n.t(title_path, scope: scope(object), name: name, default:
                    I18n.t(title_path, scope: scope(object, include_model: false), default:
                      name))

      {
        itemprop:  :item,
        itemscope: true,
        itemtype:  'http://schema.org/Thing',
        title:     title
      }
    end

    def link_tag_name(object, action)
      name = action ? i18n_action_name(object, action) : i18n_name(object)

      @view.content_tag :span, name, link_tag_name_options
    end

    def link_tag_name_options
      { itemprop: :name }
    end

    def list_options
      {
        class:     :breadcrumby,
        itemscope: true,
        itemtype:  'http://schema.org/BreadcrumbList'
      }
    end

    def meta(index)
      @view.tag :meta, content: index, itemprop: :position
    end

    def scope(object, include_model: true)
      result = [:breadcrumby]

      result << object.breadcrumby_options[:i18n_key] if include_model

      result
    end

    private

    def object_action
      @object_action ||= object_options[:actions][@options[:action]]
    end

    def object_options
      @object.breadcrumby_options
    end
  end
end

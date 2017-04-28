module Breadcrumby
  class Viewer
    def initialize(object, options = {}, view = ActionController::Base.helpers)
      @object  = object
      @options = options
      @view    = view
    end

    def breadcrumb
      return '' unless @object.respond_to?(:breadcrumby)

      list = breadcrumbs.map.with_index do |object, index|
        item link(object) + meta(index + 1)
      end

      if (action = @options[:action]).present?
        list.unshift item(link(@object, action: action) + meta(list.size + 1))
      end

      list = list.reverse.join('').html_safe

      @view.content_tag :ol, list, list_options
    end

    def breadcrumbs
      @breadcrumbs ||= @object.breadcrumby.append(Breadcrumby::Home.new(@view))
    end

    def i18n_action_name(object, action)
      I18n.t "actions.#{action}.name", scope: scope(object), default: I18n.t(action, default: 'Edition')
    end

    def i18n_name(object)
      I18n.t(:name,
        scope:   scope(object),
        default: object.send(object.breadcrumby_options[:method_name]) || '--')
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

    def link_tag_name(object, action)
      name = action ? i18n_action_name(object, action) : i18n_name(object)

      @view.content_tag :span, name, link_tag_name_options
    end

    private

    def link_tag_name_options
      { itemprop: :name }
    end

    def link_options(object, action)
      name       = i18n_name(object)
      title_path = action ? "actions.#{action}.title" : :title
      title      = I18n.t(title_path, scope: scope(object), name: name, default: name)

      {
        itemprop:  :item,
        itemscope: true,
        itemtype:  'http://schema.org/Thing',
        title:     title
      }
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

    def scope(object)
      [:breadcrumby, object.breadcrumby_options[:i18n_key]]
    end
  end
end

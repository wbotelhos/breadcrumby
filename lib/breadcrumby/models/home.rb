module Breadcrumby
  class Home
    include Breadcrumby::Extension

    def initialize(view)
      @view = view
    end

    breadcrumby i18n_key: :home

    def name
      I18n.t 'breadcrumby.home.name', default: 'Home'
    end

    def show_path
      @view.root_path
    end
  end
end

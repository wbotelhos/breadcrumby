# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Viewer, '.breadcrumb' do
  context 'when object does not respond to :breadcrumby' do
    subject { described_class.new object, options }

    let!(:object)  { {} }
    let!(:options) { {} }
    let!(:view)    { double root_path: :root_path }

    it 'returns an empty string' do
      expect(subject.breadcrumb).to eq ''
    end
  end

  context 'when object responds to :breadcrumby' do
    subject { described_class.new object, options }

    let!(:object)  { create :unit, name: 'The Unit' }
    let!(:options) { {} }
    let!(:view)    { double root_path: :root_path }

    before do
      Unit.class_eval { breadcrumby }

      allow(object).to receive(:show_path) { 'show_path' }
    end

    it 'returns the default breadcrumb' do
      expect(subject.breadcrumb).to have_tag(:ol, with: { class: 'breadcrumby', itemscope: 'itemscope', itemtype: 'http://schema.org/BreadcrumbList' }) do
        with_tag(:li, with: { itemprop: 'itemListElement', itemscope: 'itemscope', itemtype: 'http://schema.org/ListItem' }) do
          with_tag(:a, with: { itemprop: 'item', itemscope: 'itemscope', itemtype: 'http://schema.org/Thing', title: 'Home', href: '/' }) do
            with_tag(:span, with: { itemprop: 'name' }) do
              with_text 'Home'
            end
          end

          with_tag(:meta, with: { content: '1', itemprop: 'position' })
        end

        with_tag(:li, with: { itemprop: 'itemListElement', itemscope: 'itemscope', itemtype: 'http://schema.org/ListItem' }) do
          with_tag(:a, with: { itemprop: 'item', itemscope: 'itemscope', itemtype: 'http://schema.org/Thing', title: 'The Unit', href: 'show_path' }) do
            with_tag(:span, with: { itemprop: 'name' }) do
              with_text 'The Unit'
            end
          end

          with_tag(:meta, with: { content: '2', itemprop: 'position' })
        end
      end
    end
  end
end

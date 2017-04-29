# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Viewer, '.object_extra(0)' do
  context 'when :action is empty' do
    subject { described_class.new object, options }

    let!(:object)  { {} }
    let!(:options) { {} }

    it 'returns an empty array' do
      expect(subject.object_extra(0)).to eq []
    end
  end

  context 'when :action is given' do
    subject { described_class.new object, options }

    let!(:object) { create :unit }

    context 'with normal relationship' do
      let!(:options) { { action: :edit } }

      before { Unit.class_eval { breadcrumby } }

      it 'builds the :action crumb' do
        result = subject.object_extra(0)

        expect(result.size).to eq 1

        expect(result[0]).to have_tag(:li, with: { itemprop: 'itemListElement', itemscope: 'itemscope', itemtype: 'http://schema.org/ListItem' }) do
          with_tag(:a, with: { itemprop: 'item', itemscope: 'itemscope', itemtype: 'http://schema.org/Thing', title: 'translation missing: en.breadcrumby.actions.edit.title', href: 'javascript:void(0);' }) do
            with_tag(:span, with: { itemprop: 'name' }) do
              with_text 'translation missing: en.edit'
            end
          end

          with_tag(:meta, with: { content: '1', itemprop: 'position' })
        end
      end
    end

    context 'with no relationship as a new record' do
      let!(:options) { { action: :new } }

      before do
        Unit.class_eval do
          breadcrumby actions: { new: ->(_view) { School.last } }
        end
      end

      it 'builds the :action crumb' do
        result = subject.object_extra(0)

        expect(result.size).to eq 2

        expect(result[0]).to have_tag(:li, with: { itemprop: 'itemListElement', itemscope: 'itemscope', itemtype: 'http://schema.org/ListItem' }) do
          with_tag(:a, with: { itemprop: 'item', itemscope: 'itemscope', itemtype: 'http://schema.org/Thing', title: 'translation missing: en.breadcrumby.actions.index.title', href: 'unit.index.path' }) do
            with_tag(:span, with: { itemprop: 'name' }) do
              with_text 'translation missing: en.index'
            end
          end

          with_tag(:meta, with: { content: '1', itemprop: 'position' })
        end

        expect(result[1]).to have_tag(:li, with: { itemprop: 'itemListElement', itemscope: 'itemscope', itemtype: 'http://schema.org/ListItem' }) do
          with_tag(:a, with: { itemprop: 'item', itemscope: 'itemscope', itemtype: 'http://schema.org/Thing', title: 'translation missing: en.breadcrumby.actions.new.title', href: 'javascript:void(0);' }) do
            with_tag(:span, with: { itemprop: 'name' }) do
              with_text 'translation missing: en.new'
            end
          end

          with_tag(:meta, with: { content: '2', itemprop: 'position' })
        end
      end
    end
  end
end

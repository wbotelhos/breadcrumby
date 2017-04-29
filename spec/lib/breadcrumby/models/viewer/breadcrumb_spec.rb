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

    let!(:object) { create :school, name: 'The School' }
    let!(:view)   { double root_path: :root_path }
    let!(:list)   { [object] }

    before do
      allow(subject).to receive(:breadcrumbs).with(object) { [object] }
      allow(subject).to receive(:object_extra).with(list.size) { ['<li class="object_extra"></li>'] }
      allow(subject).to receive(:list_options) { { class: :list_options } }
    end

    context 'with no :actions' do
      let!(:options) { {} }

      before do
        Unit.class_eval { breadcrumby }
      end

      it 'returns the default breadcrumb' do
        expect(subject.breadcrumb).to have_tag(:ol, with: { class: 'list_options' }) do
          with_tag(:li, with: { itemprop: 'itemListElement', itemscope: 'itemscope', itemtype: 'http://schema.org/ListItem' }) do
            with_tag(:a, with: { itemprop: 'item', itemscope: 'itemscope', itemtype: 'http://schema.org/Thing', title: 'translation missing: en.breadcrumby.title', href: 'school.show.path' }) do
              with_tag(:span, with: { itemprop: 'name' }) do
                with_text 'The School'
              end
            end

            with_tag(:meta, with: { content: '1', itemprop: 'position' })
          end

          with_tag :li, with: { class: 'object_extra' }
        end
      end
    end
  end
end

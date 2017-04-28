# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Viewer, '.link' do
  subject { described_class.new object, options }

  let!(:action)  { :edit }
  let!(:object)  { build :school }
  let!(:options) { {} }

  context 'when action is not given' do
    before do
      allow(subject).to receive(:i18n_name).with(object) { :i18n_name }
      allow(subject).to receive(:link_options).with(object, nil) { { class: :custom } }
    end

    it 'build a link with object properties' do
      expect(subject.link(object)).to have_tag(:a, with: { href: 'school.path' }) do
        with_tag(:span, with: { itemprop: 'name' }) do
          with_text 'i18n_name'
        end
      end
    end
  end

  context 'when action is given' do
    before do
      allow(subject).to receive(:i18n_action_name).with(object, action) { :i18n_action_name }
    end

    it 'build a link with object and action properties' do
      expect(subject.link(object, action: action)).to have_tag(:a, with: { itemprop: 'item', itemscope: 'itemscope', itemtype: 'http://schema.org/Thing', title: object.name, href: 'javascript:void(0);' }) do
        with_tag(:span, with: { itemprop: 'name' }) do
          with_text 'i18n_action_name'
        end
      end
    end
  end
end

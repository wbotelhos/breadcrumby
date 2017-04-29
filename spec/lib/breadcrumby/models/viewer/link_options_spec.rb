# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Viewer, '.link_options' do
  subject { described_class.new object }

  let!(:object) { build :school }

  before do
    allow(subject).to receive(:i18n_name).with(object) { :i18n_name }
  end

  context 'when action is not given' do
    let!(:action) { nil }

    before do
      allow(I18n).to receive(:t).with(:title, scope: [:breadcrumby], default: :i18n_name) { 'title || name' }
      allow(I18n).to receive(:t).with(:title, scope: [:breadcrumby, 'school'], name: :i18n_name, default: 'title || name') { 'school.title || title || name' }
    end

    it 'returns the link options' do
      expect(subject.link_options(object, action)).to eq(
        itemprop:  :item,
        itemscope: true,
        itemtype:  'http://schema.org/Thing',
        title:     'school.title || title || name'
      )
    end
  end

  context 'when action is given' do
    let!(:action) { :edit }

    before do
      allow(I18n).to receive(:t).with('actions.edit.title', scope: [:breadcrumby], default: :i18n_name) { 'actions.edit.title || name' }
      allow(I18n).to receive(:t).with('actions.edit.title', scope: [:breadcrumby, 'school'], name: :i18n_name, default: 'actions.edit.title || name') { 'school.actions.edit.title || actions.edit.title || name' }
    end

    it 'returns the link options with title scoped by action fetched from i18n with root fallback' do
      expect(subject.link_options(object, action)).to eq(
        itemprop:  :item,
        itemscope: true,
        itemtype:  'http://schema.org/Thing',
        title:     'school.actions.edit.title || actions.edit.title || name'
      )
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Viewer, '.link_tag_name' do
  subject { described_class.new object, options }

  let!(:action)  { :edit }
  let!(:object)  { build :school }
  let!(:options) { {} }

  context 'when action is not given' do
    before do
      allow(subject).to receive(:i18n_name).with(object) { :i18n_name }
    end

    it 'build a ta name with object properties' do
      expect(subject.link_tag_name(object, nil)).to have_tag(:span, with: { itemprop: 'name' }) do
        with_text 'i18n_name'
      end
    end
  end

  context 'when action is given' do
    before do
      allow(subject).to receive(:i18n_action_name).with(object, action) { :i18n_action_name }
    end

    it 'build a ta name with object and action properties' do
      expect(subject.link_tag_name(object, action)).to have_tag(:span, with: { itemprop: 'name' }) do
        with_text 'i18n_action_name'
      end
    end
  end
end

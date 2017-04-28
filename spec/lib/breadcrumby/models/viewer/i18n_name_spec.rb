# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Viewer, '.i18n_name' do
  subject { described_class.new object, options, view }

  let!(:object)  { build :school }
  let!(:options) { {} }
  let!(:view)    { double }

  context 'when :method_name responds with value' do
    before do
      allow(object).to receive(:breadcrumby_options) do
        {
          i18n_key:    :i18n_key,
          method_name: :custom_method_name
        }
      end

      allow(I18n).to receive(:t).with(:edit, default: 'Edition') { 'edit || Edition' }

      allow(I18n).to receive(:t).with(
        :name, scope: %i[breadcrumby i18n_key], default: :custom_method_name
      ) { 'translation' }
    end

    it 'uses the returned value as the object name' do
      expect(subject.i18n_name(object)).to eq 'translation'
    end
  end

  context 'when :method_name does not respond with value' do
    before do
      allow(object).to receive(:breadcrumby_options) do
        {
          i18n_key:    :i18n_key,
          method_name: :custom_method_name_nil
        }
      end

      allow(I18n).to receive(:t).with(:edit, default: 'Edition') { 'edit || Edition' }

      allow(I18n).to receive(:t).with(
        :name, scope: %i[breadcrumby i18n_key], default: '--'
      ) { 'translation' }
    end

    it 'uses a default name as fallback' do
      expect(subject.i18n_name(object)).to eq 'translation'
    end
  end
end

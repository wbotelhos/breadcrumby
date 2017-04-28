# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Viewer, '.scope' do
  subject { described_class.new object }

  let!(:object) { build :school }

  context 'with default :i18n_key' do
    it 'returns a i18n scope path based on class name' do
      expect(subject.scope(object)).to eq [:breadcrumby, 'school']
    end
  end

  context 'with custom :i18n_key' do
    before do
      allow(object).to receive(:breadcrumby_options) { { i18n_key: :custom } }
    end

    it 'returns a i18n scope path based on given name' do
      expect(subject.scope(object)).to eq %i[breadcrumby custom]
    end
  end
end

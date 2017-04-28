# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Home, '.name' do
  subject { described_class.new view }

  let!(:view) { double }

  context 'when i18n key is not defined' do
    it 'returns a default name' do
      expect(subject.name).to eq 'Home'
    end
  end

  context 'when i18n key is defined' do
    before do
      allow(I18n).to receive(:t).with('breadcrumby.home.name', default: 'Home') { 'Start' }
    end

    it 'returns a default name' do
      expect(subject.name).to eq 'Start'
    end
  end
end

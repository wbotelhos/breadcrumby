# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Viewer, '.i18n_action_name' do
  subject { described_class.new object, options, view }

  let!(:object)  { build :school }
  let!(:options) { {} }
  let!(:view)    { double }
  let!(:action)  { :edit }

  before do
    allow(I18n).to receive(:t).with(:edit, default: 'Edition') { 'edit || Edition' }

    allow(I18n).to receive(:t).with(
      'actions.edit.name', scope: [:breadcrumby, 'school'], default: 'edit || Edition'
    ) { 'translation' }
  end

  it 'returns the translation for the name of given action key' do
    expect(subject.i18n_action_name(object, action)).to eq 'translation'
  end
end

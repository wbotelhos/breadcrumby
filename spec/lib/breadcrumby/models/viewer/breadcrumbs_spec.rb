# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Viewer, '.breadcrumbs' do
  subject { described_class.new object, options, view }

  let!(:object)  { build :school }
  let!(:options) { {} }
  let!(:view)    { double }
  let!(:home)    { double Breadcrumby::Home }

  before do
    Unit.class_eval { breadcrumby }

    allow(Breadcrumby::Home).to receive(:new).with(view) { home }
  end

  it 'returns the objects including the home' do
    expect(subject.breadcrumbs(object)).to eq [
      object,
      Breadcrumby::Home.new(view)
    ]
  end

  context 'when :crumbs is given' do
    let!(:crumbs) { ['object'] }

    it 'returns the objects including the given crumbs and home' do
      expect(subject.breadcrumbs(object, crumbs: crumbs)).to eq [
        object,
        'object',
        Breadcrumby::Home.new(view)
      ]
    end
  end
end

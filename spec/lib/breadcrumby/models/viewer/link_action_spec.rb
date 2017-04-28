# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Viewer, '.link_action' do
  subject { described_class.new object, options }

  let!(:action)  { :edit }
  let!(:object)  { build :school }
  let!(:options) { {} }

  context 'when action is not given' do
    it 'returns the object show route' do
      expect(subject.link_action(object, nil)).to eq object.show_path
    end
  end

  context 'when action is given' do
    it 'returns an avoid link' do
      expect(subject.link_action(object, action)).to eq 'javascript:void(0);'
    end
  end
end

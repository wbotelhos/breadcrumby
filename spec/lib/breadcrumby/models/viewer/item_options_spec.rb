# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Viewer, '.item_options' do
  subject { described_class.new object }

  let!(:object) { build :school }

  it 'returns the options used on list element' do
    expect(subject.item_options).to eq(
      itemprop:  :itemListElement,
      itemscope: true,
      itemtype:  'http://schema.org/ListItem'
    )
  end
end

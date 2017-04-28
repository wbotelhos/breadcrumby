# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Viewer, '.meta' do
  subject { described_class.new object }

  let!(:index)  { 7 }
  let!(:object) { build :school }

  it 'returns a meta element used to count the crumbs' do
    expect(subject.meta(index)).to have_tag :meta, with: { content: 7, itemprop: :position }
  end
end

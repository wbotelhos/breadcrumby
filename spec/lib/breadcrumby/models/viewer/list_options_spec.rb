# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Viewer, '.list_options' do
  subject { described_class.new object }

  let!(:object) { build :school }

  it 'returns the options used on list element' do
    expect(subject.list_options).to eq(
      class:     :breadcrumby,
      itemscope: true,
      itemtype:  'http://schema.org/BreadcrumbList'
    )
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Viewer, '.link_tag_name_options' do
  subject { described_class.new object }

  let!(:object) { build :school }

  it 'returns options used on link' do
    expect(subject.link_tag_name_options).to eq(itemprop: :name)
  end
end

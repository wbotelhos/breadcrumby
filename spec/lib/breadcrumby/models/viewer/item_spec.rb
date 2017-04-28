# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Viewer, '.item' do
  subject { described_class.new object }

  let!(:content) { :content }
  let!(:object)  { build :school }

  it 'returns a item element as node of the list' do
    expect(subject.item(content)).to have_tag :li, with: {
      itemprop:  :itemListElement,
      itemscope: :itemscope,
      itemtype:  'http://schema.org/ListItem'
    } do
      with_text :content
    end
  end

  context 'when options is given' do
    let!(:options) { { alt: :custom } }

    it 'is used' do
      expect(subject.item(content, options)).to have_tag :li, with: { alt: :custom } do
        with_text :content
      end
    end
  end
end

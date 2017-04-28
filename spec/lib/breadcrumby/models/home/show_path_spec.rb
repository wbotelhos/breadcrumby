# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Home, '.show_path' do
  context 'when route :root_path is not present' do
    subject { described_class.new view }

    let!(:view) { double }

    it 'returns the root path' do
      expect(subject.show_path).to eq '/'
    end
  end

  context 'when route :root_path is present' do
    subject { described_class.new view }

    let!(:view) { double root_path: :root_path }

    it 'returns the :root_path value' do
      expect(subject.show_path).to eq :root_path
    end
  end
end

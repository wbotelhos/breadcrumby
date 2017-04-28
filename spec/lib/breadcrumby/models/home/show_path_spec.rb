# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Home, '.show_path' do
  let!(:view) { double root_path: :root_path }

  subject { described_class.new view }

  it "returns a default name" do
    expect(subject.show_path).to eq :root_path
  end
end

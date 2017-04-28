# frozen_string_literal: true

require 'rails_helper'

class DummyHelper
  include Breadcrumby::ViewHelper
end

RSpec.describe DummyHelper, '.breadcrumby' do
  let!(:object)  { create :school, name: 'School 1' }
  let!(:options) { { key: :value } }
  let!(:helper)  { DummyHelper.new }
  let!(:viewer)  { double Breadcrumby::Viewer, breadcrumb: :breadcrumb }

  before do
    allow(Breadcrumby::Viewer).to receive(:new).with(object, options, helper) { viewer }
  end

  it 'calls breadcrumb from viewer' do
    expect(helper.breadcrumby(object, options)).to eq :breadcrumb
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Breadcrumby::Viewer, '.current_object' do
  subject { described_class.new object, options, view }

  let!(:object) { build :school }
  let!(:view)   { double }

  context 'when object has no :actions' do
    let!(:options) { {} }

    before { School.class_eval { breadcrumby } }

    it 'returns the self object' do
      expect(subject.current_object).to eq object
    end
  end

  context 'when object has :actions' do
    before do
      School.class_eval { breadcrumby actions: {} }
    end

    context 'but view action is not provided' do
      let!(:options) { {} }

      it 'returns the self object' do
        expect(subject.current_object).to eq object
      end
    end

    context 'and view action is provided' do
      let!(:options) { { action: :new } }

      context 'but object has not this action' do
        it 'returns the self object' do
          expect(subject.current_object).to eq object
        end
      end

      context 'and object has this action' do
        context 'but actions is not callable' do
          before do
            School.class_eval { breadcrumby actions: { new: :uncallable } }
          end

          it 'returns the self value' do
            expect(subject.current_object).to eq :uncallable
          end
        end

        context 'and actions is callable' do
          before do
            School.class_eval do
              breadcrumby actions: { new: ->(view) { view } }
            end
          end

          it 'returns the result call' do
            expect(subject.current_object).to eq view
          end
        end
      end
    end
  end
end

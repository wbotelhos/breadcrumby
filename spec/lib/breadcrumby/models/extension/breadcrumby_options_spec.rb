# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '.breadcrumby_options' do
  describe ':i18n_key' do
    context 'when is not given' do
      before do
        stub_const 'Dummy', Class.new

        Dummy.class_eval { include Breadcrumby::Extension }
        Dummy.class_eval { breadcrumby }
      end

      it "uses a default" do
        expect(Dummy.new.breadcrumby_options[:i18n_key]).to eq 'dummy'
      end
    end

    context 'when is given' do
      before do
        stub_const 'Dummy', Class.new

        Dummy.class_eval { include Breadcrumby::Extension }
        Dummy.class_eval { breadcrumby i18n_key: :key }
      end

      it "uses the given one" do
        expect(Dummy.new.breadcrumby_options[:i18n_key]).to eq :key
      end
    end
  end

  describe ':method_name' do
    context 'when is not given' do
      before do
        stub_const 'Dummy', Class.new

        Dummy.class_eval { include Breadcrumby::Extension }
        Dummy.class_eval { breadcrumby }
      end

      it "uses a default" do
        expect(Dummy.new.breadcrumby_options[:method_name]).to eq :name
      end
    end

    context 'when is given' do
      before do
        stub_const 'Dummy', Class.new

        Dummy.class_eval { include Breadcrumby::Extension }
        Dummy.class_eval { breadcrumby method_name: :some_name }
      end

      it "uses the given one" do
        expect(Dummy.new.breadcrumby_options[:method_name]).to eq :some_name
      end
    end
  end
end

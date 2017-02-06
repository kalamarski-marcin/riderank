require 'rails_helper'

RSpec.describe BaseForm do
  describe 'raises errors' do
    context 'when called an abstract method' do

      before :each do
        @model = double()
        @params = {}
        @form = BaseForm.new(@model, @params)
      end

      it '.save' do
        expect { @form.save }.to raise_error
      end

      it '.schema' do
        expect { @form.schema }.to raise_error
      end

      it '.validate' do
        expect { @form.validate }.to raise_error
      end

    end
  end

  describe 'set critical error' do
    context 'when invoked' do
      it '.sth_went_wrong' do
        model = double()
        params = {}
        form = BaseForm.new(model, params)
        form.sth_went_wrong
        expect(form.errors.key?(:critical)).to be_truthy
      end
    end
  end

  describe 'method missing' do

    before :each do
      @model = double()
      @params = { whatever: 'value' }
      @form = BaseForm.new(@model, @params)
    end

    it '.param_name' do
      expect(@form.whatever).to eq('value')
    end

    it '.error?' do
      @form.sth_went_wrong
      expect(@form.critical_error?).to be_truthy
    end

    it '.error' do
      @form.sth_went_wrong
      expect(@form.critical_error).to eq('Something went wrong. Please contact us.')
    end

    it 'raises ArgumentError' do
      expect { @form.test }.to raise_error(ArgumentError)
    end
  end
end

require 'rails_helper'

RSpec.describe DrawingsController, type: :controller do

  render_views

  let(:user) { FactoryBot.create(:user) }

  before(:each) do
    sign_in user
  end

  describe '#index' do

    it 'get' do
      get :index
      expect(response).to render_template :index
    end

    it 'get with invalid id' do
      get :index, params: {customer_id: 0}
      expect(response).to render_template :index

      get :index, params: {material_id: 0}
      expect(response).to render_template :index
    end

  end

  describe '#show' do

    describe 'drawing with drawing_outsource that does not have customer_id' do

      let(:drawing){ Drawing.create }

      before do
        drawing.drawing_outsources.create
      end

      it do
        get :show, params: { id: drawing }
        expect(response).to render_template :show
      end

    end

  end

end

require 'spec_helper'

describe WeightsController do

  describe 'GET #new' do

    before :each do
      get :new
    end

    it "assigns a new weight to @weight" do
      expect(assigns(:weight)).to be_a_new(Weight)
    end

    it "renders the :new template" do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do

    context 'with invalid attributes' do

      it "does not save the weight in the database" do
        expect{
          post :create,
            weight: attributes_for(:weight, date: nil)
        }.to_not change(Weight, :count)
      end

      it "re-renders the :new template" do
        post :create, weight: attributes_for(:weight, date: nil)
        expect(response).to render_template(:new)
      end
    end

    context 'with valid attributes' do

      let(:weight) { build(:weight) }

      before :each do
        controller.stub(:current_user).and_return(weight.user)
      end

      it "saves the weight in the database" do
        expect{
          post :create,
            weight: attributes_for(:weight)
        }.to change(Weight, :count).by(1)
      end

      it "redirect to user#show" do
        post :create, weight: attributes_for(:weight)
        expect(response).to redirect_to user_path(weight.user)
      end
    end
  end
end

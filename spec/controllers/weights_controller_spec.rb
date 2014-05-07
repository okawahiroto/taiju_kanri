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

  describe 'GET #edit' do

    before :each do
      @weight = create(:weight)
      get :edit, id: @weight
      controller.stub(:current_user).and_return(@weight.user)
    end

    it "assigns the required weight to @weight" do
      expect(assigns(:weight)).to eq @weight
    end

    it "renders the :edit template" do
      expect(response).to render_template(:edit)
    end
  end

  describe 'PATCH #update' do

    before :each do
      @weight = create(:weight)
      controller.stub(:current_user).and_return(@weight.user)
    end

    context "with invalid attributes" do

      before :each do
        patch :update, id: @weight, weight: attributes_for(:weight, date: nil, weight: nil)
      end

      it "doesn't change @weight's attributes" do
        @weight.reload
        expect(@weight.date).to_not eq(nil)
        expect(@weight.weight).to_not eq(nil)
      end

      it "re-renders the :edit template" do
        expect(response).to render_template(:edit)
      end
    end

    context "with valid attributes" do

      before :each do
        patch :update, id: @weight,
          weight: attributes_for(:weight, date: '2014-05-01', weight: 62.0)
      end

      it "changes @weight's attributes" do
        @weight.reload
        expect(@weight.date).to eq(Date.parse('2014-05-01'))
        expect(@weight.weight).to eq(62.0)
      end

      it "redirects to user#show" do
        expect(response).to redirect_to user_path(@weight.user)
      end
    end
  end

  describe 'DELETE #destroy' do

    before :each do
      @weight = create(:weight)
      controller.stub(:current_user).and_return(@weight.user)
    end

    it "deletes the weight" do
      expect{
        delete :destroy, id: @weight
      }.to change(Weight, :count).by(-1)
    end

    it "redirects to user#show" do
      delete :destroy, id: @weight
      expect(response).to redirect_to user_path(@weight.user)
    end
  end
end

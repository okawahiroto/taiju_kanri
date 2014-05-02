require 'spec_helper'

describe UsersController do

  let(:user) { create(:user) }

  describe 'GET #show' do

    before :each do
      get :show, id: user
    end

    it "assigns the ruquested user to @user" do
      expect(assigns(:user)).to eq user
    end

    it "renders the :show template" do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET #new' do

    before :each do
      get :new
    end

    it "assigns a new user to @user" do
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the :new template" do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do

    context 'with invalid information' do

      it "does not save the user in the database" do
        expect{
          post :create,
            user: attributes_for(:user, email: nil)
        }.to_not change(User, :count)
      end

      it "re-renders the :new template" do
        post :create, user: attributes_for(:user, email: nil)
        expect(response).to render_template(:new)
      end
    end

    context 'with valid information' do

      it "save the user in the database" do
        expect{
          post :create,
          user: attributes_for(:user)
        }.to change(User, :count).by(1)
      end

      it "redirects to #show" do
        post :create, user: attributes_for(:user)
        expect(response).to redirect_to user_path(assigns(:user))
      end
    end
  end

end

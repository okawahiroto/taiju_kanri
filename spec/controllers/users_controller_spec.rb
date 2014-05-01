require 'spec_helper'

describe UsersController do

  describe 'GET #new' do

    before :each do
      get :new
    end

    it "renders the :new template" do
      expect(response).to render_template(:new)
    end
  end

end

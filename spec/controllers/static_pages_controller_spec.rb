require 'spec_helper'

describe StaticPagesController do

  describe "GET 'index'" do

    it "renders the :index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET 'about'" do

    it "renders the :about template" do
      get :about
      expect(response).to render_template(:about)
    end
  end

  describe "GET 'contact'" do

    it "renders the :contact template" do
      get :contact
      expect(response).to render_template(:contact)
    end
  end

end

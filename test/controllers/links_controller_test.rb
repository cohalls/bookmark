require 'test_helper'

class LinksControllerTest < ActionDispatch::IntegrationTest
  describe "GET index" do
    it "assigns @links" do
      link = Link.create
      get :index
      expect(response).to have_http_status :success
    end
  end

  describe "links#create" do
    it "should allow new links to be created" do
      post :create, params: {link: {title: "Bookmark Title"}}
      expect(response).to have_http_status(:success)
      expect(Link.last.title).to eq("Bookmark Title")
    end
  end
end

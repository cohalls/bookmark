require 'rails_helper'

RSpec.describe LinksController, type: :controller do
  describe "GET index" do
    it "should successfully show the page" do
      get :index
      expect(response).to have_http_status :success
    end
  end

  describe "links#create" do
    it "should allow new links to be created" do
      user = FactoryBot.create(:user)
      sign_in user

      post :create, params: {
        link: { title: "Bookmark Title",
                url: "www.bookmark.com",
                tags: ['']
            }
          }
      expect(response).to redirect_to links_path
      expect(Link.last.title).to eq("Bookmark Title")
    end
  end
end

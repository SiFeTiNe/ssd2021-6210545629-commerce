require 'rails_helper'

RSpec.describe "TestArticles", type: :request do

  describe "GET /index" do
    it "returns http success" do
      get "/test_products/index"
      expect(response).to have_http_status(:success)
    end
  end

end

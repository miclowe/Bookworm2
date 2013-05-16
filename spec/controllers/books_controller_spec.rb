require 'spec_helper'

describe BooksController do

  describe "search" do
    it "takes a search parameter" do
      query = "Harry Potter"
      get :search, :query => query
      expect(assigns(:query)).to eq query
    end

    it "returns results" do
      query = "Harry Potter"
      get :search, :query => query
      expect(response).to be_success
      expect(assigns(:books))
    end
  end
end
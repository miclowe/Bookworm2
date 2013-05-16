require 'spec_helper'

describe BookbagsController do

  before do
    @user = User.create!(:email => "abcdefg@gmail.com", :password => "secret")
  end

  after do
    Bookbag.destroy_all
  end

  describe "show" do
    it "loads the books in a user's bookbag into @books" do
      book1 = Book.create!(:title => "You Suck", :gr_id => 123456)
      book2 = Book.create!(:title => "A Dirty Job", :gr_id => 987654)
      bookbag1 = Bookbag.create!(:user_id => @user.id, :book_id => book1.id)
      bookbag2 = Bookbag.create!(:user_id => @user.id, :book_id => book2.id)
      sign_in @user
      get :show
      expect(assigns(:booksinbag).size).to eq 2
      expect(assigns(:booksinbag)).to include book1
      expect(assigns(:booksinbag)).to include book2
    end
  end

  describe "remove" do
    it "deletes user's bookbag" do
      pending
      book1 = Book.create(:title => "You Suck", :gr_id => 123456)
      bookbag = Bookbag.create(:book_id => book1.id, :user_id => @user.id)
      sign_in @user
      expect(bookbag.id).to eq 1
      delete :remove, :id => bookbag
      expect(bookbag).to be_nil
      # bookbag.reload
      # expect(bookbag.id).to be_nil
    end
  end

end
require 'spec_helper'

describe User do

  before(:each) do
    @user = User.new
    @user.first_name = "Michelle"
    @user.last_name = "Lowe"
    @user.email = "abcdefg@gmail.com"
    @user.password = "secret"
  end

  it "has a first name" do
    expect(@user.first_name).to eq "Michelle"
  end

  it "has a last name" do
    expect(@user.last_name).to eq "Lowe"
  end

  it "has an email" do
    expect(@user.email).to eq "abcdefg@gmail.com"
  end

  it "has a password" do
    expect(@user.password).to eq "secret"
  end

  it "has many books through a bookbag" do
    user = User.create!(:email => "abcdefg@gmail.com",
                        :password => "secret")
    book1 = Book.create!(:title => "You Suck",
                        :gr_id => 123456)
    book2 = Book.create!(:title => "A Dirty Job",
                        :gr_id => 987654)
    bookbag1 = Bookbag.create!(:user_id => user.id, :book_id => book1.id)
    bookbag2 = Bookbag.create!(:user_id => user.id, :book_id => book2.id)

    expect(user.books).to be_an Array
    expect(user.books.size).to eq 2
    expect(user.books).to include book1
    expect(user.books).to include book2
  end

end
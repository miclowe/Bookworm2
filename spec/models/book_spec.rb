require 'spec_helper'

describe Book do

  before(:each) do
    @book = Book.new
    @book.title = "A Dirty Job"
    @book.author = "Christopher Moore"
    @book.description = "Charlie Asher is a pretty normal guy. A little hapless, somewhat neurotic, sort of a hypochondriac."
    @book.isbn = "0060590270"
    @book.cover_url = "http://www.goodreads.com/book/photo/33456.A_Dirty_Job"
    @book.work_id = 3258721
    @book.gr_id = 33456
  end

  it "has a title" do
    expect(@book.title).to eq "A Dirty Job"
  end

  it "has an author" do
    expect(@book.author).to eq "Christopher Moore"
  end

  it "has a description" do
    expect(@book.description).to eq "Charlie Asher is a pretty normal guy. A little hapless, somewhat neurotic, sort of a hypochondriac."
  end

  it "has an isbn" do
    expect(@book.isbn).to eq "0060590270"
  end

  it "has a cover url" do
    expect(@book.cover_url).to eq "http://www.goodreads.com/book/photo/33456.A_Dirty_Job"
  end

  it "has a work id" do
    expect(@book.work_id).to eq 3258721
  end

  it "has a goodreads id" do
    expect(@book.gr_id).to eq 33456
  end

  it "has many users through a bookbag" do
    book = Book.create!(:title => "You Suck",
                        :gr_id => 123456)
    user1 = User.create!(:email => "abcdefg@gmail.com",
                          :password => "secret")
    user2 = User.create!(:email => "zyxwvu@yahoo.com",
                          :password => "secret2")
    bookbag1 = Bookbag.create!(:user_id => user1.id, :book_id => book.id)
    bookbag2 = Bookbag.create!(:user_id => user2.id, :book_id => book.id)

    expect(book.users).to be_an Array
    expect(book.users.size).to eq 2
    expect(book.users).to include user1
    expect(book.users).to include user2
  end

end
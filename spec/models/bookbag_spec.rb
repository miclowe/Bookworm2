require 'spec_helper'

describe Book do

  before(:each) do
    @bookbag = Bookbag.new
    @bookbag.book_id = 123456
    @bookbag.user_id = 2
  end

  it "has a book id" do
    expect(@bookbag.book_id).to eq 123456
  end

  it "has a user id" do
    expect(@bookbag.user_id).to eq 2
  end

end
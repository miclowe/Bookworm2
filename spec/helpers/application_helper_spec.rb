require 'spec_helper'

describe ApplicationHelper do
  describe "title" do
    it "sets the title for all pages" do
      helper.title("RSpec testing is fun!")
      expect(helper.content_for(:title)).to eq("RSpec testing is fun!")
    end
  end
end

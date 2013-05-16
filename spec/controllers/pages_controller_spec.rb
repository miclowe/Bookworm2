require 'spec_helper'

describe PagesController do

  describe "index" do
    it "responds successfully with an HTTP 200 status code" do
    get :index
    expect(response).to be_success
    expect(response.status).to eq 200
    end
  end

  describe "contact" do
    it "responds successfully with an HTTP 200 status code" do
    get :contact
    expect(response).to be_success
    expect(response.status).to eq 200
    end
  end

  # describe "send_email" do
  #   it "sends an email from user to site administrator"
  #   user = User.new(:email => "mklowe2012@gmail.com")
  # end

end
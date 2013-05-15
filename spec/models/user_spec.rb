require 'spec_helper'

describe User do

  before(:each) do
    @user = User.new
    @user.first_name = "Michelle"
    @user.last_name = "Lowe"
    @user.email = "mklowe2012@gmail.com"
    @user.password = "secret"
  end

  it "has a first name" do
    expect(@user.first_name).to eq "Michelle"
  end

  it "has a last name" do
    expect(@user.last_name).to eq "Lowe"
  end

  it "has an email" do
    expect(@user.email).to eq "mklowe2012@gmail.com"
  end

  it "has a password" do
    expect(@user.password).to eq "secret"
  end

end
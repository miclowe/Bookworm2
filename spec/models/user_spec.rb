require 'spec_helper'

describe User do

  it "has a first name" do
    user = User.new(:first_name => "Michelle")
    expect(user.first_name).to eq "Michelle"
  end

  it "has a last name" do
    user = User.new(:last_name => "Lowe")
    expect(user.last_name).to eq "Lowe"
  end

  it "has an email" do
    user = User.new(:email => "mklowe2012@gmail.com")
    expect(user.email).to eq "mklowe2012@gmail.com"
  end

  it "has a password" do
    user = User.new(:password => "testpassword")
    expect(user.password).to eq "testpassword"
  end

end
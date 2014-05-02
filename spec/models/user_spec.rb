require 'spec_helper'

describe User do

  let(:user) { build(:user) }

  it "has valid factory" do
    expect(user).to be_valid
  end

  describe "attributes" do

    it "has name" do
      expect(user).to respond_to(:name)
    end

    it "has email" do
      expect(user).to respond_to(:email)
    end

    it "has password_digest" do
      expect(user).to respond_to(:password_digest)
    end

    it "has password" do
      expect(user).to respond_to(:password)
    end

    it "has password_confirmation" do
      expect(user).to respond_to(:password_confirmation)
    end

    it "has remember_token" do
      expect(user).to respond_to(:remember_token)
    end

    it "has authenticate" do
      expect(user).to respond_to(:authenticate)
    end

    it "has admin" do
      expect(user).to respond_to(:admin)
    end
  end

  it "is invalid without name" do
    expect(
      build(:user, name: " ")
    ).to have(1).errors_on(:name)
  end

  it "is invalid without email" do
    expect(
      build(:user, email: " ")
    ).to have(2).errors_on(:email)
  end

  it "is invalid without password" do
    expect(
      build(:user, password: nil)
    ).to have(2).errors_on(:password)
  end

  it "is invalid if name is too long" do
    expect(
      build(:user, name: "a" * 51)
    ).to have(1).errors_on(:name)
  end

  it "is invalid if email format is invalid" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.
      foo@bar_baz.com foo@bar+baz.com]
    addresses.each do |invalid_address|
      invalid_user = build(:user, email: invalid_address)
      expect(invalid_user).not_to be_valid
    end
  end

  it "is valid if email format is valid" do
    addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
    addresses.each do |valid_address|
      valid_user = build(:user, email: valid_address)
      expect(valid_user).to be_valid
    end
  end

  it "is invalid with a duplicate email" do
    create(:user, email: 'same@example.com')
    expect(
            build(:user, email: 'same@example.com')
    ).to have(1).errors_on(:email)
  end

  it "is invalid if password doesn't match confirmation" do
    expect(
      build(:user, password: "password", password_confirmation: "wrong_password")
    ).to have(1).errors_on(:password_confirmation)
  end

  it "is invalid if password is too short" do
    expect(
      build(:user, password: "a" * 5, password_confirmation: "a" * 5)
    ).to have(1).errors_on(:password)
  end
end

require 'spec_helper'

describe Weight do

  let(:weight) { build(:weight) }

  it "has valid factory" do
    expect(weight).to be_valid
  end

  describe "attributes" do

    it "has date" do
      expect(weight).to respond_to(:date)
    end

    it "has weight" do
      expect(weight).to respond_to(:weight)
    end

    it "has user" do
      expect(weight).to respond_to(:user)
    end
  end

  it "has invalid without date" do
    expect(
      build(:weight, date: nil)
    ).to have(1).errors_on(:date)
  end

  it "has invalid without weight" do
    expect(
      build(:weight, weight: nil)
    ).to have(2).errors_on(:weight)
  end

  it "has invalid without user_id" do
    expect(
      build(:weight, user_id: nil)
    ).to have(1).errors_on(:user_id)
  end

  it "has invalid with a duplicate date & user" do
    create(:weight, date: '2014-04-01', user_id: 1)
    expect(
      build(:weight, date: '2014-04-01', user_id: 1)
    ).to have(1).errors_on(:user_id)
  end

  it "has invalid if weight is less than 0" do
    expect(
            build(:weight, weight: -1.0)
    ).to have(1).errors_on(:weight)
  end
end

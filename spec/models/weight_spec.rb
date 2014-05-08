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

  describe "the current weight & current date" do

    before :each do
      @user1 = create(:user)
      @user1_weight1 = @user1.weights.create(date: '2014-05-01', weight: 65.0)
      @user1_weight2 = @user1.weights.create(date: '2014-05-02', weight: 66.0)

      @user2 = create(:user)
      @user2_weight1 = @user2.weights.create(date: '2014-05-03', weight: 67.0)
      @user2_weight2 = @user2.weights.create(date: '2014-05-04', weight: 68.0)
    end

    it "returns the current weight" do
      expect(Weight.current_weight(@user1)).to eq(@user1_weight2)
    end
  end

end

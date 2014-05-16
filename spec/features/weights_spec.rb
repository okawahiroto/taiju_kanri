require 'spec_helper'

describe "weights" do

  let(:user) { create(:user) }

  it "creates weight" do
    sign_in(user)

    click_link '体重を登録する'

    fill_in '年月日(yyyy-mm-dd)', with: '2014-06-01'
    fill_in '体重', with: '60.0'
    expect{
      click_button '登録する'
    }.to change(Weight, :count).by(1)
  end

  describe "update & delete" do

    let(:weight) { create(:weight) }

    it "update weight" do
      sign_in(weight.user)
      click_link '修正'
      fill_in '体重', with: "55.0"
      click_button '登録する'
      expect(page).to have_content("55.0")
    end

    it "delete weight" do
      sign_in(weight.user)
      expect{
        click_link '削除'
      }.to change(Weight, :count).by(-1)
    end

  end

end

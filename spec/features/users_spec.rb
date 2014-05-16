require 'spec_helper'

describe 'users' do

  let(:user) { create(:user) }

  it "creates user" do
    visit root_path
    click_link 'ユーザー登録 »'

    fill_in '名前', with: "Example User"
    fill_in 'メールアドレス', with: "example@example.com"
    fill_in '目標体重(kg)', with: "65.0"
    fill_in 'user_password', with: "password"
    fill_in 'user_password_confirmation', with: "password"

    expect{
      click_button '登録する'
    }.to change(User, :count).by(1)
  end

  it "updates user" do
    sign_in(user)

    click_link 'Account'
    click_link 'Settings'

    fill_in '名前', with: 'Update User'
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    click_button '登録する'

    expect(page).to have_title('Update User')
  end

  it "deletes user" do
    sign_in(user)

    click_link 'Account'
    click_link 'Settings'
    expect{
      click_link 'ユーザー情報の削除'
    }.to change(User, :count).by(-1)
  end

end

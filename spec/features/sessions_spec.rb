require "spec_helper"

describe "sessions" do
  let(:user) { create(:user) }

  it "signs me in" do
    sign_in(user)
    expect(page).to have_title(user.name)
  end

  it "signs me out" do
    sign_in(user)
    click_link "Account"
    click_link "Sign out"
    expect(page).to_not have_title(user.name)
  end
end

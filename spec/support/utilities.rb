def sign_in(user)
  visit signin_path
  fill_in 'メールアドレス', with: user.email
  fill_in 'パスワード', with: user.password
  click_button 'サインイン'
end

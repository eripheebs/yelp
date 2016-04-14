def sign_up
  visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: 'misa@misa.com'
  fill_in 'Password', with: '123456789'
  fill_in 'Password confirmation', with: '123456789'
  click_button 'Sign up'
end

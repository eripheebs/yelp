def sign_up_one
  visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: 'misa@misa.com'
  fill_in 'Password', with: '123456789'
  fill_in 'Password confirmation', with: '123456789'
  click_button 'Sign up'
end

def sign_up_two
  visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: 'misa2@misa.com'
  fill_in 'Password', with: '123456789'
  fill_in 'Password confirmation', with: '123456789'
  click_button 'Sign up'
end

def add_kfc
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'KFC'
  click_button 'Create a restaurant'
end

def add_nandos
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'Nando\'s'
  click_button 'Create a restaurant'
end

def add_invalid_restaurant
  click_link 'Add a restaurant'
  fill_in 'Name', with: 'kf'
  click_button 'Create a restaurant'
end

def leave_review
  visit restaurants_path
  click_link 'Review KFC'
  fill_in 'Thoughts', with: 'average'
  select '3', from: 'Rating'
  click_button 'Leave a review'
end

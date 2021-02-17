Given('I am logged in as a user') do
  @user = create(:user)
  login_as @user
end

Given('I visit the Leagues page') do
  visit leagues_path
end

Given('I visit the {string} league page') do |name|
  league = League.find_by(name: name)
  visit league_path(league)
end

When('I click link {string}') do |link_name|
  click_link(link_name)
end

When('I click the {string} button and accept the alert') do |button_name|
  accept_confirm do
    click_link(button_name)
  end
end

When('I fill {string} with {string}') do |field, value|
  field.downcase!
  field_id = field.gsub(/\s+/, '-')
  field.gsub!(/\s+/, '_')
  name = find("input[name*=#{field}], textarea[name*=#{field}], ##{field_id}")[:name]
  fill_in(name, with: value)
end

Then('I click {string}') do |button_name|
  click_button(button_name)
end

Then('I am on the {string} page') do |page_title|
  expect(page).to have_content(page_title)
end

Then('{string} is present') do |name|
  expect(page).to have_content(name)
end

Then('{string} is not present') do |name|
  expect(page).not_to have_content(name)
end

Given('a league called {string} exists') do |name|
  @league = create(:league, name: name)
end

Given('I have created a league called {string}') do |name|
  @user = create(:user)
  @league = create(:league, name: name, user: @user)
  login_as @user
end

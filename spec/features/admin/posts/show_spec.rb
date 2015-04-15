require 'rails_helper.rb'

feature 'Show a post', js: true do
  before do
    FactoryGirl.create(:post, title: 'Baked Potato w/ Cheese', body: 'a body')
    FactoryGirl.create(:post, title: 'Baked Brussel Sprouts', body: 'the second body')
  end
  scenario 'finding posts' do
    visit '/admin'
    click_on "Baked Brussel Sprouts"

    expect(page).to have_content("Baked Brussel Sprouts")
    expect(page).to have_content("the second body")

    click_on "Back"

    expect(page).to have_content("Baked Brussel Sprouts")
    expect(page).to_not have_content("the second body")
  end
end
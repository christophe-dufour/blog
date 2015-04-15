require 'rails_helper.rb'

feature 'Looking up posts', js: true do
  before do
    FactoryGirl.create(:post, title: 'Baked Potato w/ Cheese')
    FactoryGirl.create(:post, title: 'Garlic Mashed Potatoes')
    FactoryGirl.create(:post, title: 'Potatoes Au Gratin')
    FactoryGirl.create(:post, title: 'Baked Brussel Sprouts')
  end
  scenario 'finding posts' do
    visit '/admin'
    fill_in 'keywords', with: 'baked'
    click_on 'Search'

    expect(page).to have_content('Baked Potato')
    expect(page).to have_content('Baked Brussel Sprouts')
  end
end
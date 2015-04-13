require 'rails_helper'
# Feature: Articles page
#   As a visitor
#   I want to visit the articles page
#   So I can see published articles
feature 'Articles page' do

  background do
    @unpublished_post = create(:post)
    @published_post = create(:published_post)
  end

  # Scenario: Visit the home page
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I see the title of a published post
  scenario 'visit the home page and see a published post' do
    visit root_path
    expect(page).to have_content @published_post.title
  end

  # Scenario: Visit the home page
  #   Given I am a visitor
  #   When I visit the home page
  #   Then I can't see the title of a not published post
  scenario 'visit the home page and see a published post' do
    visit root_path
    expect(page).to_not have_content @unpublished_post.title
  end

end

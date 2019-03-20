require "rails_helper"

RSpec.feature "Game", :type => :feature do

  scenario "home page" do
    visit "/"

    expect(page).to have_text("New Game")
  end
  
  scenario "start new game" do
    visit "/games/new"
    within("#new_game") do
      fill_in 'game_players', with: 3
      uncheck 'game_rollover_scoring'
    end

    click_button 'Play!'

    expect(page).not_to have_text("Player 0")
    expect(page).to have_text("Player 1")
    expect(page).to have_text("Player 2")
    expect(page).to have_text("Player 3")
    expect(page).not_to have_text("Player 4")
    expect(page).to have_text("0") #score
    expect(page).to have_text("Score: 0") #score
  end

  scenario "bank points" do
    visit "/games/new"

    click_button 'Play!'
    click_link 'three_ones: 1000'
    
    expect(page).to have_text("1000") #game score
    
    click_link 'Bank'
    expect(page).to have_text("Score: 1000") #player score
  end
end
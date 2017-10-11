require "rails_helper"

RSpec.feature "Users can create new projects" do
  before do
    login_as(FactoryGirl.create(:user, :admin))
    visit "/"

    click_link "New Project"
  end

  scenario "with valid attributes" do
    fill_in "Name", with: "Atom"
    fill_in "Description", with: "A text editor"
    click_button "Create Project"

    expect(page).to have_content "Project has been created"

    project = Project.find_by(name: "Atom")
    expect(page.current_url).to eq project_url(project)

    title = "Atom - Projects - Ticketee"
    expect(page).to have_title title
  end

  scenario "when providing invalid attributes" do
    fill_in "Name", with: ""
    click_button "Create Project"

    expect(page).to have_content "Project has not been created"
    expect(page).to have_content "Name can't be blank"
  end
end
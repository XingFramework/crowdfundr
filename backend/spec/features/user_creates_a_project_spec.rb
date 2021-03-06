require "spec_helper"

RSpec.steps "Visitor Creates a New Project", js: :true, vcr: {} do

  let :name do
    "Pie in the Sky"
  end

  let :description do
    "Delivering fresh-baked pies via drones!"
  end

  let :deadline do
    Time.utc(2115, 3, 14)
  end

  let :goal do
    31415.92
  end

  it "visits root" do
    visit "/"
  end

  it "is on the homepage" do
    expect(page).to have_content("Create a New Project")
  end

  it "clicks link" do
    click_button("Create a New Project")
  end

  it "is on the new-project page" do
    expect(page).to have_content("New Project")
  end

  it "fills in form information" do
    fill_in "Name", with: name
    fill_in "Description", with: description
    fill_in "Deadline", with: deadline
    fill_in "Goal", with: goal
  end

  it "submits new project" do
    click_button "Save"
  end

  it "redirects to project detail page" do
    expect(page).to have_content("Pie in the Sky")
  end
end

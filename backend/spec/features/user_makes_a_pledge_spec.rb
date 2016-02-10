require 'spec_helper'

RSpec.steps 'User makes a pledge', :js => true, :vcr => {} do
  before :all do
    @project = FactoryGirl.create(:project)
  end

  step 'visit home page' do
    visit '/'
  end

  it 'should display name of available projects' do
    expect(page).to have_content(@project.name)
  end

  step 'view project details' do
    click_link 'View'
  end

  it 'should display description, deadline, and goal of the project' do
    expect(page).to have_content('Description')
    expect(page).to have_content(@project.description)
    expect(page).to have_content('Deadline')
    expect(page).to have_content(@project.deadline.strftime('%Y-%m-%d'))
    expect(page).to have_content('Goal')
    expect(page).to have_content(@project.goal)
  end

  step 'click on Make a Pledge button' do
    click_button 'Make a Pledge'
  end

  it 'should display a pledge form on a modal' do
    expect(page).to have_content('Amount')
    expect(page).to have_content('Comment')
    expect(page).to_not have_content('Pledge as Anonymous')
  end

  step 'fill in pledge form and submit' do
    fill_in 'amount', :with => '25'
    fill_in 'comment', :with => 'This is worthy of my money'
    click_button 'Submit'
  end

  # TODO: Display of pledge amounts and comments to be done in next tickets:
  # #113318461 and #113318613
end

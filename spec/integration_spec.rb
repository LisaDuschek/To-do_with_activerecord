require('capybara/rspec')
require('./app')
require("spec_helper")

Capybara.app = Sinatra::Application
set(:show_exceptions, false)


describe('adding a new list', {:type => :feature}) do
	it('allows a user to click a list to see the tasks and details for it') do
		visit('/')
		click_link('Add New List')
		fill_in('name', :with => 'epicodus work')
		click_button('Add List')
		expect(page).to have_content('Success!')
	end
	
end

describe('viewing all of the lists', {:type => :feature}) do
	it('allows a user to see all of the lists that have been created') do
		list = List.new({:name => 'epicodus homework', :id => nil})
		list.save()
		visit('/')
		click_link('View All Lists')
		expect(page).to have_content(list.name)
	end
end

describe('seeing details for a single list', {:type => :feature}) do
	it('allows a user to click a list to see the tasks and details for it') do
		test_list = List.new({:name => 'school stuff', :id => nil}) #needs :id => nil in hash?
		test_list.save()
		test_task = Task.new({:description => "learn SQL", :list_id => test_list.id()})
		test_task.save()
		visit('/lists')
		click_link(test_list.name())
		expect(page).to have_content(test_task.description())
	end
end

describe('adding tasks to a list', {:type => :feature}) do
	it('allows a user to add a task to a list') do
		test_list = List.new({:name => 'school stuff', :id => nil}) #needs :id => nil in hash?
		test_list.save()
		visit("/tasks/#{test_list.id()}")
		fill_in("description", {:with => "learn SQL"})  #original text
		click_button("Submit")
		expect(page).to have_content("Success")
	end
end


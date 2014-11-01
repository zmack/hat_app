require_relative '../test_helper'

class HatsViewsControllerTest < ActionController::TestCase
  tests HatsController

  def setup
    Hat.nuke
  end

  test "the new template contains all necessary form fields" do
    get :new

    assert_tag :form, :attributes => { :action => "/hats", :method => "post" }
    assert_tag :input, :attributes => { :type => "text", :name => "hat[name]" }
    assert_tag :input, :attributes => { :type => "text", :name => "hat[size]" }

    assert_tag :input, :attributes => {:type => "submit" }
  end

  test "accessing the a hat's edit page renders the edit template" do
    Hat.create({ :name => "Fedora", :size => 1 })

    get :edit, :id => 1

    assert_tag :form, :attributes => { :action => "/hats/1" }
    assert_tag :input, :attributes => { :type => "text", :name => "hat[name]", :value => "Fedora" }
    assert_tag :input, :attributes => { :type => "text", :name => "hat[size]", :value => "1" }
  end
end

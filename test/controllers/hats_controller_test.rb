require 'test_helper'

class HatsControllerTest < ActionController::TestCase
  def setup
    Hat.nuke
  end

  test "The root route is hats index" do
    assert_routing '/', { :controller => "hats", :action => "index" }
  end

  test "Hat-specific resource routes exist" do
    assert_routing '/hats/new', { :controller => "hats", :action => "new" }
    assert_routing({ :method => :get, :path => '/hats/1' }, { :controller => "hats", :action => "show", :id => "1" })
    assert_routing({ :method => :patch, :path => '/hats/1' }, { :controller => "hats", :action => "update", :id => "1" })
    assert_routing({ :method => :delete, :path => '/hats/1' }, { :controller => "hats", :action => "destroy", :id => "1" })
    assert_routing '/hats/1/edit', { :controller => "hats", :action => "edit", :id => "1" }
  end

  test "accessing the new hat page renders the new template" do
    get :new
    assert_template "hats/new"
  end

  test "accessing the index page renders the index template" do
    get :index
    assert_template "hats/index"
  end

  test "accessing the a hat's show page renders the show template" do
    Hat.create({ :name => "Fedora", :size => 1 })

    get :show, :id => 1
    assert_template "hats/show"
  end

  test "accessing the an inexistent hat's show page does not render a template and returns a 404" do
    get :show, :id => 1

    assert_template nil
    assert_response 404
  end

  test "accessing the a hat's edit page renders the edit template" do
    Hat.create({ :name => "Fedora", :size => 1 })

    get :edit, :id => 1
    assert_template "hats/edit"
  end

  test "accessing the an inexistent hat's edit page does not render a template and returns a 404" do
    get :edit, :id => 1

    assert_template nil
    assert_response 404
  end

  test "posting to the create page adds a hat" do
    post :create, :hat => { :name => "Fedora", :size => 1 }

    assert_not_nil Hat.find_by_id 1
  end

  test "posting to the create redirects to the created hat's show page" do
    post :create, :hat => { :name => "Fedora", :size => 1 }

    assert_redirected_to({ :action => :show, :id => 1 })
  end

  test "sending a patch to the update page updates the hat" do
    Hat.create({ :name => "Fedora", :size => 1 })

    patch :update, :id => 1, :hat => { :name => "Moose", :size => 1 }

    hat = Hat.find_by_id(1)

    assert_equal "Moose", hat.name
  end

  test "sending a patch to the update page redirects to the created hat's show page" do
    Hat.create({ :name => "Fedora", :size => 1 })
    patch :update, :id => 1, :hat => { :name => "Moose", :size => 1 }

    assert_redirected_to({ :action => :show, :id => 1 })
  end

  test "sending a patch an inexistent hat's update page does not render a template and returns a 404" do
    patch :update, :id => 1, :hat => { :name => "Moose", :size => 1 }

    assert_template nil
    assert_response 404
  end
end

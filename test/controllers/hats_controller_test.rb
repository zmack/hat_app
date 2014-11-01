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
end

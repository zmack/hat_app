require_relative '../test_helper'

class HatTest < ActiveSupport::TestCase
  def setup
    Hat.nuke
  end

  def teardown
  end

  test "Hats exist" do
    assert defined?(Hat), "Hat should be defined"
  end

  test "Hats have a size, a name, and an id" do
    h = Hat.new

    assert_respond_to h, :size
    assert_respond_to h, :name
    assert_respond_to h, :id
  end

  test "Hats are initialized with a hash" do
    hat = Hat.new({ :size => 1, :name => "Fedora" })

    assert_equal 1, hat.size
    assert_equal "Fedora", hat.name
  end

  test "Hats get assigned an id on save" do
    hat = Hat.new({ :size => 1, :name => "Fedora" })

    assert_equal nil, hat.id

    hat.save

    assert_equal 1, hat.id
  end

  test "Hats automatically assign sequential ids" do
    first_hat = Hat.new({ :size => 1, :name => "Fedora" })
    first_hat.save

    second_hat = Hat.new({ :size => 1, :name => "Moose" })
    second_hat.save

    assert_equal 1, first_hat.id

    assert_equal 2, second_hat.id
  end

  test "Hats have a create method, that automatically saves them" do
    hat = Hat.create({ :size => 1, :name => "Fedora" })

    assert_equal 1, hat.id
  end

  test "Hats can be found by id" do
    hat = Hat.new({ :size => 1, :name => "Fedora" })
    hat.save

    assert_equal nil, Hat.find_by_id(1024)

    assert_equal hat, Hat.find_by_id(1)
  end

  test "Hats can be found by name" do
    hat = Hat.create({ :size => 1, :name => "Fedora" })

    assert_equal [], Hat.find_by_name("Moose")

    assert_equal [hat], Hat.find_by_name("Fedora")
  end

  test "If multiple hats share the same name, they're all returned" do
    first_hat = Hat.create({ :size => 1, :name => "Fedora" })
    second_hat = Hat.create({ :size => 3, :name => "Fedora" })

    assert_equal [], Hat.find_by_name("Moose")

    returned_hats = Hat.find_by_name("Fedora")

    assert_includes returned_hats, first_hat
    assert_includes returned_hats, second_hat
    assert_equal 2, returned_hats.length
  end

  test "It can find hats by regexp" do
    first_hat = Hat.create({ :size => 1, :name => "Fedora" })
    second_hat = Hat.create({ :size => 3, :name => "Felora" })

    Hat.create({ :size => 3, :name => "Moose" })
    Hat.create({ :size => 3, :name => "Goose" })

    assert_equal [], Hat.find_by_name(/oat/)

    returned_hats = Hat.find_by_name(/Fe.ora/)

    assert_includes returned_hats, first_hat
    assert_includes returned_hats, second_hat
    assert_equal 2, returned_hats.length
  end

  test "Hats can get updated" do
    hat = Hat.create({ :size => 1, :name => "Fedora" })

    assert_equal 1, hat.id

    hat.update({ :name => "Moose", :size => 0 })

    assert_equal "Moose", hat.name
    assert_equal 0, hat.size
  end

  test "Hats do not update nil attributes" do
    hat = Hat.create({ :size => 1, :name => "Fedora" })

    assert_equal 1, hat.id

    hat.update({ :name => "Moose", :size => nil })

    assert_equal "Moose", hat.name
    assert_equal 1, hat.size
  end
end

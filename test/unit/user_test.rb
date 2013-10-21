require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "a user should enter a first name" do
    user = User.new
    assert !user.save
    assert !user.errors[:first_name].empty?
  end
  
  test "a user should enter a last name" do
    user = User.new
    assert !user.save
    assert !user.errors[:last_name].empty?
  end

  test "a user should enter a profile name" do
    user = User.new
    assert !user.save
    assert !user.errors[:profile_name].empty?
  end
  
#  test "a user should have a unique profile name" do
#    user              = User.new
#    user.profile_name = 'jasonseifer'
#    user.email        = 'jason@teamtreehouse.com'
#    user.first_name   = 'Jason'
#    user.last_name    = 'Seifer'
#    user.password     = 'password'
#    user.password_confirmation = 'password'    
#    
#    assert !user.save
#    assert !user.errors[:profile_name].empty?
#  end

  test "a user should have a unique profile name" do
    user              = User.new
    user.profile_name = users(:jason).profile_name

    assert !user.save
    assert !user.errors[:profile_name].empty?
  end
  
  test "a user should have a profile name without spaces" do
    user = User.new( first_name: 'Jason',
                     last_name:  'Seifer',
                     email:      'jason2@teamtreehouse.com' )
    user.password = 'asdfasdf'
    user.password_confirmation = 'asdfasdf'

    user.profile_name = "Mike The Frog"

    # assert_equal( "Mike The Frog", user.profile_name, "profile_name set to " + user.profile_name )
    # refute_match( /^[a-zA-Z0-9_-]+$/, user.profile_name, "profile_name vs. regex" )
    assert !user.save
    assert !user.errors[:profile_name].empty?
    # The string in the .include?("") below must match exactly the string in user.rb:
    #  -- validates -> profile_name -> format: -> { message: ""} string or
    #  -- this test will fail.
    assert user.errors[:profile_name].include?("Must be formatted correctly."), "That's all folks!"
  end
  
  test "a user can have a correctly formatted profile name" do
    user = User.new( first_name: 'Jason',
                     last_name:  'Seifer',
                     email:      'jason2@teamtreehouse.com' )
    user.password = 'asdfasdf'
    user.password_confirmation = 'asdfasdf'
    user.profile_name = 'jasonseifer_1'
    
    assert user.valid? "Validated a user with a correctly formatted profile name"
  end
  
end

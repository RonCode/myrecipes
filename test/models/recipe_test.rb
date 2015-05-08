require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.new(chefname: "bob", email: "bob@example.com")
    @recipe = Recipe.new(name: "chicken parm", summary: "this is the best 
              chicken parm recipe ever!", description: "heat oil, add onions, 
              add tomato sauce, add chicken, cook for 20 minutes")
  end
  
  #test case to if valid
  test "recipe should be valid" do 
    assert @recipe.valid?
  end
  
  test "chef_id should be valid" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  #test name if valid, returns false if no name, assert_not expects a false
  test "name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test "name length must not be too long" do
    @recipe.name = "a" * 101
    assert_not @recipe.valid?
  end
  
  test "name length should not be too short" do
    @recipe.name = "aaaa"
    assert_not @recipe.valid?
  end
  
  #test summary if valid, returns false if no name, assert_not expects a false
  test "summary must be present" do
    @recipe.summary = "a" * 151
    assert_not @recipe.valid?
  end

  test "summary length must not be too long" do
    @recipe.summary = "a" * 9
    assert_not @recipe.valid?
  end
  
  test "summary length should not be too short" do
    @recipe.summary = "a" * 151
    assert_not @recipe.valid?    
  end  

  #test description if valid, returns false if no name, assert_not expects a false
  test "description must be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end

  test "description length must not be too long" do
    @recipe.description = "a" * 19
    assert_not @recipe.valid?   
  end
  
  test "description length should not be too short" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid? 
  end  
  
end

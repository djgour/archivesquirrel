require 'spec_helper'

describe "Deleting an item" do
  
  # These tests need to be able to work with Javascript
  # because of the confirmation window that pops up when
  # you try to delete an item.
  
  it "should let a project admin delete an item"
  
  it "should let the item's creator delete an item"
  
  it "shouldn't be done by a member that isn't a creator or admin"
  
end
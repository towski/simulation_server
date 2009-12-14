require "#{File.dirname(__FILE__)}/../main"

class AddIndexes < ActiveRecord::Migration
  def self.up
    add_index :terrain, :x
    add_index :terrain, :y
    add_index :animals, :x
    add_index :animals, :y
  end

  def self.down
  end
end

AddIndexes.up

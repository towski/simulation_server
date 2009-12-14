require "#{File.dirname(__FILE__)}/../main"

class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.timestamps
      t.integer :x, :y
    end
  end

  def self.down
    drop_table :users
  end
end

CreateUsers.up

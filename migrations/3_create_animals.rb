require "#{File.dirname(__FILE__)}/../main"

class CreateAnimal < ActiveRecord::Migration
  def self.up
    create_table :animals do |t|
      t.timestamps
      t.integer :x, :y, :user_id
      t.string :species
    end
  end

  def self.down
    drop_table :animals
  end
end

CreateAnimal.up

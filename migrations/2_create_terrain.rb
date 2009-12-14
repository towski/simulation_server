require "#{File.dirname(__FILE__)}/../main"

class CreateTerrain < ActiveRecord::Migration
  def self.up
    create_table :terrain do |t|
      t.timestamps
      t.integer :width, :height, :x, :y
      t.string :kind
    end
  end

  def self.down
    drop_table :terrain
  end
end

CreateTerrain.up

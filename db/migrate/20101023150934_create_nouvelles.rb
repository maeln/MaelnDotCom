class CreateNouvelles < ActiveRecord::Migration
  def self.up
    create_table :nouvelles do |t|
		t.string :title
		t.string :autor
		t.string :tags
		t.text :corp

      t.timestamps
    end
  end

  def self.down
    drop_table :nouvelles
  end
end

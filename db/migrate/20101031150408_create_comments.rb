class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.references :nouvelle
		t.string :pseudo
		t.string :mail
		t.text :corp

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end

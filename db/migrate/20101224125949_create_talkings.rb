class CreateTalkings < ActiveRecord::Migration
  def self.up
    create_table :talkings do |t|
		t.string :pseudo
		t.text :msg

      t.timestamps
    end
  end

  def self.down
    drop_table :talkings
  end
end

class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
    	t.string :photo_id
    	t.string :user_id
    	t.string :date_time
    	t.string :comment
      t.timestamps
    end
  end
end

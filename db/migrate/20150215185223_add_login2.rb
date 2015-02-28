class AddLogin2 < ActiveRecord::Migration
  def change
  	remove_column :users, :login
  	add_column :users, :login,:string
  	User.reset_column_information
  	users = User.all
  	users.each do |user|
  		user.update_attribute(:login, user.last_name.downcase)
  	end
  end
end

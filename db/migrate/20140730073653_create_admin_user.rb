class CreateAdminUser < ActiveRecord::Migration
  def change
    User.create!(:email => 'admin@carlyle.com', :password => 'password', :role => 'admin')
  end
end

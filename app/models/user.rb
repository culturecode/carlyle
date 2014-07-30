class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable,
  devise :invitable, :database_authenticatable, :rememberable,
         :recoverable, :trackable, :validatable

  def self.owner
    @owner ||= User.where(:role => 'owner').first_or_create!(:password => 'password', :email => 'owner@carlyle.com')
  end

  validates_inclusion_of :role, :in => ['admin', 'council', 'manager', 'owner']
end

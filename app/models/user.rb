class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable, :registerable,
  devise :invitable, :database_authenticatable, :rememberable,
         :recoverable, :trackable, :validatable

  def self.owner
    @owner ||= User.where(:role => 'owner').first_or_create!(:password => 'password', :email => 'owner@carlyle.com')
  end

  validates_inclusion_of :role, :in => ['admin', 'council', 'manager', 'owner']
  validate :owner_role_is_read_only

  private

  def owner_role_is_read_only
    errors.add(:role, "Can't change owner to another role (owner user is singleton)") if role_changed? && role_was == 'owner'
  end
end

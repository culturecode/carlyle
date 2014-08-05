class Person < ActiveRecord::Base
  validates_presence_of :name

  has_many :suite_ownerships, lambda { where(:relationship => 'owner') }, :class_name => 'SuitePerson'
  has_many :suites_owned, :through => :suite_ownerships, :source => :suite

  has_many :suite_occupancies, lambda { where(:relationship => 'tenant') }, :class_name => 'SuitePerson'
  has_many :suites_rented, :through => :suite_occupancies, :source => :suite


  def to_s
    self.name
  end
end

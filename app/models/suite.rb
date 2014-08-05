class Suite < ActiveRecord::Base

  has_many :suite_tenants, lambda { where(:relationship => 'tenant') }, :class_name => 'SuitePerson'
  has_many :tenants, :through => :suite_tenants, :source => :person

  has_many :suite_owners, lambda { where(:relationship => 'owner') }, :class_name => 'SuitePerson'
  has_many :owners, :through => :suite_owners, :source => :person

  has_many :lockers

  accepts_nested_attributes_for :tenants, :owners

  validates_uniqueness_of :number

  def to_s
    "Suite #{number}"
  end
end

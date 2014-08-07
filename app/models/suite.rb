class Suite < ActiveRecord::Base

  has_many :suite_tenants, lambda { where(:relationship => 'tenant') }, :class_name => 'SuitePerson', :dependent => :destroy
  has_many :tenants, :through => :suite_tenants, :source => :person, :after_remove => proc {|suite, tenant| SuitePersonObserver.instance.after_remove_tenant(suite, tenant) }

  has_many :suite_owners, lambda { where(:relationship => 'owner') }, :class_name => 'SuitePerson', :dependent => :destroy
  has_many :owners, :through => :suite_owners, :source => :person, :after_remove => proc {|suite, owner| SuitePersonObserver.instance.after_remove_owner(suite, owner) }

  has_many :lockers, :dependent => :nullify, :after_remove => proc {|suite, locker| LockerObserver.instance.after_remove(suite, locker) }

  accepts_nested_attributes_for :tenants, :owners

  validates_uniqueness_of :number

  def to_s
    "Suite #{number}"
  end
end

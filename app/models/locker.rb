class Locker < ActiveRecord::Base
  belongs_to :suite

  validates_uniqueness_of :number

  def to_s
    "Locker #{id}"
  end
end

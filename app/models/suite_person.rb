class SuitePerson < ActiveRecord::Base
  belongs_to :person
  belongs_to :suite
end

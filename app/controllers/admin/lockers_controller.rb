module Admin
  class LockersController < ApplicationController
    load_and_authorize_resource

    def create
      numbers = params.fetch(:lockers, {})[:numbers].split(/\D+/).uniq
      numbers.each do |number|
        Locker.create(:number => number)
      end

      redirect_to [:admin, :lockers], :notice => "#{numbers.count} #{numbers.count == 1 ? 'Locker' : 'Lockers'} created"
    end
  end
end

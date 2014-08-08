module Admin
  class LockersController < ApplicationController
    respond_to :html
    load_and_authorize_resource

    def create
      numbers = params.fetch(:lockers, {})[:numbers].split(/\D+/).uniq
      numbers.each do |number|
        Locker.create(:number => number)
      end

      redirect_to [:admin, :lockers], :notice => "#{numbers.count} #{numbers.count == 1 ? 'Locker' : 'Lockers'} created"
    end

    def edit; end
    def rent; end

    def update
      @locker.update_attributes(locker_params)
      respond_with(:admin, @locker)
    end

    private

    def locker_params
      permitted_params = []
      permitted_params.unshift(:number, :location, :description) if can? :edit, Locker
      permitted_params.unshift(:suite_id) if can? :rent, Locker
      params.require(:locker).permit(permitted_params)
    end
  end
end

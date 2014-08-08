module Admin
  class SuitesController < ApplicationController
    respond_to :html
    load_and_authorize_resource

    def index
      @suites.order!(:number)
    end

    def new; end

    def create
      numbers = params.fetch(:suites, {})[:numbers].split(/\D+/).uniq
      numbers.each do |number|
        Suite.create(:number => number)
      end

      redirect_to [:admin, :suites], :notice => "#{numbers.count} #{numbers.count == 1 ? 'Suite' : 'Suites'} created"
    end

    def update
      @suite.update_attributes(suite_params)
      respond_with(:admin, @suite)
    end

    private

    def suite_params
      permitted_params = [:owner_ids => [], :owners_attributes => [:name, :email, :phone, :_destroy], :tenant_ids => [], :tenants_attributes => {}]
      permitted_params.unshift(:locker_ids => []) if can? :rent, Locker
      params.fetch(:suite, {}).permit(permitted_params)
    end
  end
end

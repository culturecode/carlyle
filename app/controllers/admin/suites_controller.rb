module Admin
  class SuitesController < ApplicationController
    respond_to :html
    load_and_authorize_resource

    def new; end

    def create
      numbers = params.fetch(:suites, {})[:numbers].split(/\D+/).uniq
      numbers.each do |number|
        Suite.create(:number => number)
      end

      redirect_to [:admin, :suites], :notice => "#{numbers.count} #{numbers.count == 1 ? 'Suite' : 'Suites'} created"
    end

    def update
      previous_tenants = @suite.tenants.to_a
      previous_owners  = @suite.owners.to_a
      previous_lockers = @suite.lockers.to_a

      @suite.update_attributes(suite_params)

      if @suite.owners.sort != previous_owners.sort
        diff_cry(@suite, "owned by", @suite.owners.to_sentence.presence || 'nobody')
        association_diff_cry(@suite.owners, 'owns', @suite, previous_owners)
      end

      if @suite.tenants.sort != previous_tenants.sort
        diff_cry(@suite, "rented by", @suite.tenants.to_sentence.presence || 'nobody')
        association_diff_cry(@suite.tenants, 'rents', @suite, previous_tenants)
      end

      if @suite.lockers.sort != previous_lockers.sort
        diff_cry(@suite, "rents", @suite.lockers.to_sentence)
        association_diff_cry(@suite.lockers, 'rented by', @suite, previous_lockers)
      end

      respond_with(:admin, @suite)
    end

    private

    def suite_params
      permitted_params = [:owner_ids => [], :tenant_ids => []]
      permitted_params.unshift!(:locker_ids => []) if can? :rent, Locker
      params.require(:suite).permit(permitted_params)
    end
  end
end

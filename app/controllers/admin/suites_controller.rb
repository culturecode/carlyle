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
      previous_owners    = @suite.owners.to_a

      @suite.update_attributes(suite_params)

      suite_people_notifications(@suite, :owners, previous_owners, 'owns')
      suite_people_notifications(@suite, :tenants, previous_tenants, 'occupies')

      respond_with(:admin, @suite)
    end

    private

    def suite_params
      params.require(:suite).permit(:owner_ids => [], :tenant_ids => [], :locker_ids => [])
    end

    # Create notifications for changes to people related to the suite
    # creates notifications for the suite, and people whose relationship has changed
    def suite_people_notifications(suite, association, was, verb)
      if suite.send(association).sort != was.sort
        suite_people_cry(suite, "#{association} changed", suite.send(association).to_sentence)

        (suite.send(association) - was).each do |person|
          person_cry(person, "now #{verb}", suite)
        end
        (was - suite.send(association)).each do |person|
          person_cry(person, "no longer #{verb}", suite)
        end
      end
    end

    def suite_people_cry(suite, action, people)
      cry("#{suite} #{action} to #{people}", :subject => suite, :people => people)
    end

    def person_cry(person, action, suite)
      cry("#{person} #{action} #{suite}", :subject => person, :suite => suite.to_s)
    end
  end
end

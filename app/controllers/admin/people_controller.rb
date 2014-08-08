module Admin
  class PeopleController < ApplicationController
    load_and_authorize_resource

    respond_to :html

    def index
      @people.order!(:name).joins!(:suite_people).uniq!
    end

    def show; end

    def update
      @person.update_attributes(person_params)
      respond_with(:admin, @person)
    end

    private

    def person_params
      params.require(:person).permit(:name, :email, :phone)
    end
  end
end

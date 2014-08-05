module Admin
  class PeopleController < ApplicationController
    load_and_authorize_resource

    def show; end
  end
end

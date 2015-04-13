module Api
  class ApiController < ApplicationController

    before_action :check_logged_in

#    rescue_from CanCan::AccessDenied do |exception|
#      render json: 'Not authorized', status: 401, formats: [:json]
#    end
    def default_serializer_options
      {root: false}
    end

    private

    def check_logged_in
      #TODO
    end
  end
end
module Api
  class ApiController < ApplicationController

    before_action :check_logged_in

#    rescue_from CanCan::AccessDenied do |exception|
#      render json: 'Not authorized', status: 401, formats: [:json]
#    end
    def default_serializer_options
      {root: false}
    end


    rescue_from Mongoid::Errors::DocumentNotFound do |e|
      render nothing: true, status: 404
    end
    private

    def check_logged_in
      #TODO
    end
  end
end
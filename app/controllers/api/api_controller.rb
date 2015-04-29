module Api
  class ApiController < ApplicationController

    before_action :check_logged_in

    def default_serializer_options
      {root: false}
    end


    rescue_from Mongoid::Errors::DocumentNotFound do |e|
      render nothing: true, status: 404
    end
    private

    def check_logged_in
      render nothing: true, status: 403 unless session[:admin]
    end
  end
end
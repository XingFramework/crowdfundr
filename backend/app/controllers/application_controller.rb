class ApplicationController < Xing::Controllers::Base
  rescue_from CanCan::AccessDenied do |exception|
    render json: {}, status: 401
  end
end

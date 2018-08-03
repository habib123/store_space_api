class Api::V1::BaseController < ApplicationController
  API_VERSION = 'v1'
  API_HEADERS_CONTENT_TYPE = 'application/json'
  API_HEADERS_ACCEPT = "application/vnd.store2be.api.v1+json"
  before_action :check_accept_header
  before_action :check_content_type_header, only: %i(create update)

  respond_to :json
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response


  private

  def render_unprocessable_entity_response(exception)
    render json: exception.record.errors, status: :unprocessable_entity
  end

  def render_not_found_response(exception)
    render json: { 'error': exception.message }, status: :not_found
  end

  def check_content_type_header
    return if request.headers['Content-Type']&.include?(API_HEADERS_CONTENT_TYPE)

    render json: { errors: ['unsupported content type'] }, status: :unsupported_media_type
  end

  def check_accept_header
    return if request.headers['Accept'] == API_HEADERS_ACCEPT

    render json: { errors: ['not acceptable'] }, status: :not_acceptable
  end
end

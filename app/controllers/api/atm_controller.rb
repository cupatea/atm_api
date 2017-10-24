class Api::AtmController < ApplicationController
  # respond_to :json

  def withdraw
    @outcome = Withdraw.run params
    _render_response
  end

  def refill
    @outcome = Refill.run params
    _render_response
  end

private
  def _render_response
    status = @outcome.valid? ? :ok : :unprocessable_entity
    render json: {
      success: @outcome.valid?,
      result:  @outcome.valid? ? @outcome.result : @outcome.errors.full_messages.to_sentence
      }, status: status
  end
end

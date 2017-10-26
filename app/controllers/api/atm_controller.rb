class Api::AtmController < ApplicationController

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
    render json: {
      success: @outcome.errors.blank?,
      result:  @outcome.valid? ? @outcome.result : nil,
      errors:  @outcome.valid? ? nil : @outcome.errors.full_messages.to_sentence
    }, status: @outcome.valid? ? :ok : :unprocessable_entity
  end
end

class HealthController < ApplicationController
  def health
    render json: {api: 'OK'}, status: :ok #0k = 200
  end
end
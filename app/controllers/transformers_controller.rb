class TransformersController < ApplicationController
  include UrlHelper
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def create
    transformer = Transformer.new(transformer_params)

    if transformer.save
      render json: { nickname: transformer.nickname, redirect_url: build_url(transformer.nickname) }
    else
      render json: transformer.errors, status: :unprocessable_entity
    end
  end

  def show
    @transformer = Transformer.find_by(nickname: params[:nickname])
    raise ActiveRecord::RecordNotFound unless @transformer

    redirect_link = @transformer.user_url
    redirect_link.prepend('http://') unless redirect_link.match?(/\Ahttps?:\/\//)
    redirect_to redirect_link
  end

  def destroy
    @transformer = Transformer.find_by(nickname: params[:nickname])
    raise ActiveRecord::RecordNotFound unless @transformer

    @transformer.destroy
    render json: { message: 'removed' }
  end

  private
    def record_not_found
      render json: { error: '404 Not Found' }, status: :not_found
    end

    def transformer_params
      params.require(:transformer).permit(:user_url)
    end
end

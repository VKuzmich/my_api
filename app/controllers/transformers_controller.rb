class TransformersController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def create
    @transformer = Transformer.new(transformer_params)
    if @transformer.save
      render json: { nickname: @transformer.nickname }
    else
      redirect_to @transformer
    end
  end

  def show
    @transformer = Transformer.find_by(nickname: params[:nickname])
    raise ActiveRecord::RecordNotFound unless @transformer

    render json: { user_url: @transformer.user_url}
  end

  def destroy
    @transformer = Transformer.find_by(nickname: params[:nickname])
    raise ActiveRecord::RecordNotFound unless @transformer

    @transformer.destroy
    render json: { message: 'removed'}
  end

  private

  def record_not_found
    render json: {error: '404 Not Found'}, status: :not_found
  end

  def transformer_params
    params.require(:transformer).permit(:user_url, :nickname)
  end
end

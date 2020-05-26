class TransformersController < ApplicationController

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # POST
  def create
    @transformer = Transformer.new(transformer_params)

    if @transformer.save
      render json: { nickname: @transformer.nickname }
    else
      redirect_to @transformer
    end
  end

  # GET / 1
  def show
    @transformer = Transformer.find_by(nickname: params[:nickname])

    if @transformer.present?
      render json: { user_url: @transformer.user_url}
    else
      render status: 404
    end

  end

  # DELETE
  def destroy
    @transformer = Transformer.find_by(nickname: params[:nickname])
    raise ActiveRecord::RecordNotFound unless @transformer
          # status: 404 unless @transformer

    # rescue_from ActiveRecord::RecordNotFound
    # Use Mongoid::Errors::DocumentNotFound with mongoid
    # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found


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

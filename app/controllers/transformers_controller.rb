class TransformersController < ApplicationController

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

    render json: { user_url: @transformer.user_url}
  end

  # DELETE
  def destroy
    @transformer = Transformer.find_by(nickname: params[:nickname])
    @transformer.destroy
    # head :no_content
    render json: { message: 'removed'}
  end

  private

  def transformer_params
    params.require(:transformer).permit(:user_url, :nickname)
  end
end

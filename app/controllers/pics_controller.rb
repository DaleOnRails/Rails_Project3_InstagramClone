class PicsController < ApplicationController

  # 1
  def index
  end

  #2-new and create will correspond to new.html view file
  def new
    @pic = Pic.new
  end

  #3-now i need to define the params in a private method. Once params are created in a priv meth i can re-use them and keep code #DRY
  def create
    @pic = Pic.new(pic_params)
  end

  private

  #4
  def pic_params
    params.require(:pic).permit(:title, :description)
  end
end

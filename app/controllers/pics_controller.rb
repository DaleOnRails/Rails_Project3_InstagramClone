class PicsController < ApplicationController
  #13---because to find a pic the app must FIRST find it by its id. This before action needs to happen to grab the id of the pic first so it can then edit/update/destroy and show it. Because how can these actions be executed without the app kowing what post to execute it on obvioulsy?
  before_action :find_pic, only: [:show, :edit, :update, :destroy]

  # 1
  def index
  end

  #11 - to show a picture need to first find it by its id
  def show
    @pic = Pic.find(params[:id])
  end

  #2-new and create will correspond to new.html view file
  def new
    @pic = Pic.new
  end

  #3-now i need to define the params in a private method. Once params are created in a priv meth i can re-use them and keep code #DRY
  def create
    @pic = Pic.new(pic_params)

    if @pic.save #9 - add rendering for error messages
      #feedback to user that post has been saved
      redirect_to @pic, notice: "Yay! Your pic' has been posted"
    else
      #else render so they can try again. (Not redirect because redirect will http refresh and #discard the content user is trying to save/upload)
      render "new"
    end
  end

  private

  #4
  def pic_params
    params.require(:pic).permit(:title, :description)
  end

  #12
  def find_pic
    @pic = Pic.find(params[:id])
  end
end

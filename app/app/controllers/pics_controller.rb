class PicsController < ApplicationController
  #13---because to find a pic the app must FIRST find it by its id. This before action needs to happen to grab the id of the pic first so it can then edit/update/destroy and show it. Because how can these actions be executed without the app kowing what post to execute it on obvioulsy?
  before_action :find_pic, only: [:show, :edit, :update, :destroy, :upvote]
  #this defines non authenticated user priveleges. In other words users who arent logged in can only view the picture itself and the index page of all the pictures just like the real insta app.
  before_action :authenticate_user!, except: [:index, :show]

  # 1 - lists all pics in descending order
  def index
    @pics = Pic.all.order("created_at DESC")
  end

  #11 - to show a picture need to first find it by its id
  #doesnt need find by id param here because this was defined in the private method. this method is included in the show view file instead to keep code DRY!
  def show
  end

  #2-new and create will correspond to new.html view file
  def new
    # @pic = Pic.new this is a problem - it isnt specifying WHO created the picture - because i want to diplsay the user id who created the pic (in user.rb) i have to use the below line of code.
    @pic = current_user.pics.build
  end

  #3-now i need to define the params in a private method. Once params are created in a priv meth i can re-use them and keep code #DRY
  def create
    @pic = current_user.pics.build(pic_params)

    if @pic.save #9 - add rendering for error messages
      #feedback to user that post has been saved
      redirect_to @pic, notice: "Yay! Your pic' has been posted"
    else
      #else render so they can try again. (Not redirect because redirect will http refresh and #discard the content user is trying to save/upload)
      render "new"
    end
  end

  #15. similar to show method = doesnt need find pic by id because i have defined it in the private method below. All i have to do is include that 'find_pic' method inside of the edit view file.
  def edit
  end

  #16 - for update and create = unlike the edit method they do not have a view file. they are responsible for making changees in the database. therefore these methods need to be defined.
  def update
    if @pic.update(pic_params)
      #verify that update was succesful to the user
      redirect_to @pic, notice: "Awesome! Your Pic was updated!"
    else #if this update fails
      render "edit"
    end
  end

  #   step 18: included this method in thee before action. now just need to attach the destroy method #to the @pic variable so it knows WHAT to destroy and a redirect action
  def destroy
    @pic.destroy
    redirect_to root_path
  end

  #defined in the before action at top of the file
    #in other words once a user has voted on a pic then takke the user back to the pictures show page / keep the user on that picture
  def upvote  
    @pic.upvote_by current_user  
    redirect_back fallback_location: root_path
  end

  private

  #4
  def pic_params
    params.require(:pic).permit(:title, :description, :image)
  end

  #12
  def find_pic
    @pic = Pic.find(params[:id])
  end
end

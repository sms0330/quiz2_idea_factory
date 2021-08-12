class IdeasController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]
    before_action :find_idea, only: [:edit, :update, :show, :destroy]
    before_action :authorize_user!, only: [:edit, :update, :destroy]
  
    def new
        @idea = Idea.new
    end
  
    def create
        @idea = Idea.new idea_params
        @idea.user = current_user
        if @idea.save
            flash[:notice] = 'Idea Created Successfully'
            redirect_to idea_path(@idea.id)
        else
            render :new
        end
    end
  
    def edit
    end
  
    def update
        if @idea.update idea_params
            flash[:notice] = 'Idea Updated Successfully'
            redirect_to idea_path(@idea.id)
        else
            render :edit
        end
    end
  
    def index 
        @ideas = Idea.all.order(created_at: :desc)
    end
  
    def show
        @review = Review.new
        @reviews = @idea.reviews.order(created_at: :desc)
        @like = @idea.likes.find_by(user: current_user)
    end
  
    def destroy
        @idea.destroy
        redirect_to ideas_path
    end
  
    private
    def find_idea
        @idea ||= Idea.find params[:id]
    end
  
    def idea_params
        params.require(:idea).permit(:title, :description)
    end

    def authorize_user!
        redirect_to root_path, alert: 'Not authorized! please try again' unless can?(:crud, @idea)
    end
  
end

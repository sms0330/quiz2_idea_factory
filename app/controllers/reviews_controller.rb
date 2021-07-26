class ReviewsController < ApplicationController
    before_action :authenticate_user!, except: [:show, :index]

    def create
        review_params = params.require(:review).permit(:body)
        @review = Review.new review_params
        @idea = Idea.find params[:idea_id]
        @review.idea = @idea
        @review.user = current_user

        if can? :crud, @review
            if @review.save
                redirect_to idea_path(@idea), notice: "New review!"
            else
                @reviews = @idea.reviews.order(created_at: :desc)
                render 'ideas/show', alert: "error!"
            end
        else
            redirect_to root_path, alert: "Not authorized!"
        end

    end

    def destroy
        review = Review.find params[:id]
        if can? :crud, review
            review.destroy
            redirect_to idea_path(review.idea_id)
        else
            redirect_to root_path, alert: "Not authorized!"
        end
    end
end

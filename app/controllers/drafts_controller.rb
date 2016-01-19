class DraftsController < ApplicationController
	def index
			@drafts = Draft.all
	end

	def new
		@draft=Draft.new

	end

	def create
		# @draft=Draft.new(draft_params)
		# @draft.user=current_user
		@draft = current_user.drafts.new(draft_params)
		@draft.status="未審理"
		if @draft.save
			flash[:notice] = "投稿成功!!"
			redirect_to welcome_path
		else
			render :new
		end

	end

	def show

	end

	def edit
		@draft = Draft.find(params[:id])
	end

	def update

		@draft = Draft.find(params[:id])
			if @draft.update(draft_params)
    	  flash[:notice] = "編輯成功"
    	  redirect_to admin_draft_url
    	else
      render :action => :edit
    end
	end

	protected

	def draft_params

		params.require(:draft).permit(:name,:content,:istrue,:privacy,:industry_id,:position_id,:working_time,:answer1, :bootsy_image_gallery_id)

	end

end

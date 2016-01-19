class Admin::DraftsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin
  before_action :set_draft, :only=>[:show, :edit, :update, :destroy]

     def index
      @drafts = Draft.all
     end

    def show
      #   if params[:draft_id]
      # @draft = Draft.find(:draft_id)

    end

    def new
     @draft = Draft.new
    end

    def create
     @draft = current_user.drafts.new(draft_params)
     if current_user.role == "admin"
       @draft.status= "小編"
     end
     if @draft.save

      redirect_to admin_topics_path
    else
      render :new
    end
             #raise
           end

           def draft_upload
            ids = Array( params[:ids] )
            # drafts = ids.map{ |i| Draft.find_by_id(i) }.compact
            drafts = Draft.where(id: ids)

            if params[:commit] == "Delete"

             drafts.each { |d| d.destroy }
             flash[:alert] = "刪除成功"
            redirect_to admin_topics_path

            elsif params[:commit] == "Publish"

              drafts.each do |d|
                 @topic = Topic.new
                 @topic.name = d.name
                 @topic.position_id = d.position_id
                 @topic.industry_id = d.industry_id
                 @topic.user_id = d.user_id
                 @topic.duration = d.duration
                 @topic.save
               d.status = "已上傳"
               d.save

               flash[:notice] = "上傳成功"

              end

              redirect_to admin_topics_path
           end
         end


         def edit

         end

         def update
          if @draft.update(draft_params)
            flash[:alert]="新增成功"
            redirect_to admin_topics_path
          else
            render :action => :edit

          end
        end

        def destroy
          @draft.destroy
          flash[:alert] = "刪除成功"
          redirect_to admin_topics_path

        end

        protected

        def set_draft

         @draft = Draft.find(params[:id])
       end

       def check_admin
         unless current_user.admin?
          raise AvtiveRecord::RecordNotFound
        end
      end

      def draft_params
        params.require(:draft).permit(:name, :privacy, :istrue, :content, :answer1, :answer2, :industry_id, :position_id, :working_time, :duration, :user_id, :bootsy_image_gallery_id)
      end

    end
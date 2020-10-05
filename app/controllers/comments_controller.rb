class CommentsController < ApplicationController

    def create
        #byebug
        #@comment = Comment.create(comment_params)
        @comment = Comment.create({
            content: params[:content],
            commentee_id: params[:commentee_id],
            commenter_id: params[:commenter_id]
        })
        @comment.likes = 0
        @comment.save
        redirect_to musician_path(params[:commentee_id])
    end

    def like
        #byebug
        @comment = Comment.find(params[:id])
        @comment.likes += 1
        @comment.save
        redirect_to musician_path(params[:commentee_id])
    end


    def comment_params
        params.require(:comment).permit(:content, :commenter_id, :commentee_id, :likes)
    end


#     <div class="card text-center">
# <%@comments.each do |comment|%>
  
#     </ul>
#   </div>
#   <div class="card-body">
#     <h5 class="card-title"> <%= comment.content%> </h5>
#     <p class="card-text">
    
# Made by: <%=comment.commenter.name%> <br/> likes: <%=comment.likes%> 
# <br/>
# <%=form_with url: like_comment_path(comment) do |f|%>
# <%=f.hidden_field :commentee_id, :value => @musician.id%>
# <%=f.hidden_field :commenter_id, :value => @current_user.id %>
# <%=f.submit "Like"%>
# <%end%>
#     </p>
    
#   </div>
#   <%end%>
# </div>
# </div>
end

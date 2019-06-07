class CommentsController < ApplicationController
  def create
    if params[:report_id]
      @report = Report.find(params[:report_id])
      @comment = @report.comments.create(comment_params)
      @comment.user_id = current_user.id
      @comment.save
      redirect_to report_path(@report)
    elsif params[:book_id]
      @book = Book.find(params[:book_id])
      @comment = @book.comments.create(comment_params)
      @comment.user_id = current_user.id
      @comment.save
      redirect_to book_path(@book)
    end
  end

  def destroy
    if params[:report_id]
      @report = Report.find(params[:report_id])
      @comment = @report.comments.find(params[:id])
      @comment.destroy
      redirect_to report_path(@report)
    else
      @book = Book.find(params[:book_id])
      @comment = @book.comments.find(params[:id])
      @comment.destroy
      redirect_to book_path(@book)
    end
  end

  def edit
    if params[:report_id]
      @report = Report.find(params[:report_id])
      @comment = @report.comments.find(params[:id])
    else
      @book = Book.find(params[:book_id])
      @comment = @book.comments.find(params[:id])
    end
  end

  def update
    if params[:report_id]
      @report = Report.find(params[:report_id])
      @comment = @report.comments.find(params[:id])
      @comment.update(comment_params)
      redirect_to report_path(@report)
    else
      @book = Book.find(params[:book_id])
      @comment = @book.comments.find(params[:id])
      @comment.update(comment_params)
      redirect_to book_path(@book)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:commenter, :body)
  end
end

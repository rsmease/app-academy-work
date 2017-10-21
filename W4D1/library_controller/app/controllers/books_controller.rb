class BooksController < ApplicationController
  def index
    @books = Book.all
    index
  end

  def new
    render :new
  end

  def create
    book = Book.new(book_params)
    if book.save
      index
    else
      flash.now[:errors] = book.errors.full_messages
      render :new
    end
  end

  def destroy
    kill_me = Book.find_by(id: params[:id])
    kill_me.destroy
    index
  end

  private
  def book_params
    params.require(:book).permit(:title, :author)
  end
end

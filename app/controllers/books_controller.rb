class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      flash.now[:alert] = "Failed to create book due to the following error."
      render :index
    end
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      flash.now[:alert] = "Failed to update book due to the following error."
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.delete
      flash[:notice] = "Book was successfully deleted."
      redirect_to '/books'
    else
      @books = Book.all
      flash.now[:alert] = "Failed to delete book."
      render :index
    end
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end

end

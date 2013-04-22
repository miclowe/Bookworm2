class BookbagsController < ApplicationController

  before_filter :store_location
  before_filter :authenticate_user!

  def show
    @booksinbag = current_user.books
  end

  def remove
    @id = params[:id].to_i
    @book = Bookbag.find_by_book_id_and_user_id(@id, current_user.id)
    # raise @book.inspect
    @book.destroy

    respond_to do |format|
      format.html { redirect_to bookbag_url }
      format.json { head :no_content }
    end
  end

end

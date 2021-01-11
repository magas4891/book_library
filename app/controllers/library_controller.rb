class LibraryController < ApplicationController
  before_action :authentificate_user!

  def index
    @library_books = current_user.library_additions
  end
end

require 'open-uri'
require 'nokogiri'

class BooksController < ApplicationController

  before_filter :store_location
  before_filter :authenticate_user!, :only => [:add_to_bookbag]

  def search
    @query = params[:query]

    url = "http://www.goodreads.com/search.xml?key=#{ENV['GOODREADS_KEY']}&q=#{URI.escape@query}"
    d = Nokogiri::XML(open(url))

    @books = []
    d.xpath('//search/results/work').each do |node|

      book = {}

      book[:title] = node.at_xpath('./best_book/title').content
      book[:work_id] = node.at_xpath('./id').content
      book[:gr_id] = node.at_xpath('./best_book/id').content
      book[:author] = node.at_xpath('./best_book/author/name').content
      book[:pub_year] = node.at_xpath('./original_publication_year').content
      book[:sm_image_url] = node.at_xpath('./best_book/small_image_url').content

      @books << book
    end

  end

  def detail
    @id = params[:id]
    @book = Book.where(:gr_id => params[:id]).first
    @bookdetail = []
    detail = {}

    url = "http://www.goodreads.com/book/show/#{@id}?format=xml&key=#{ENV['GOODREADS_KEY']}"
    d = Nokogiri::XML(open(url))
    # raise d.inspect

    if !@book.nil?

      detail[:title] = @book.title
      detail[:author] = @book.author
      detail[:isbn] = @book.isbn
      detail[:description] = @book.description
      detail[:cover_url] = @book.cover_url
      detail[:work_id] = @book.work_id

      @bookdetail << detail
      # raise @bookdetail.inspect
    else

      detail[:title] = d.at_xpath('//book/title').content
      detail[:author] = d.at_xpath('//book/authors/author/name').content
      detail[:isbn] = d.at_xpath('//book/isbn').content
      detail[:description] = d.at_xpath('//book/description').content.gsub(/<[^<>]*>/, "")
      detail[:cover_url] = d.at_xpath('//book/image_url').content
      detail[:work_id] = d.at_xpath('//book/work/id').content

      @bookdetail << detail
    end
    # raise @bookdetail.inspect

    @booksimilar = []

    d.xpath('//book/similar_books/book').each do |node|

      similar = {}
      similar[:title] = node.at_xpath('./title').content
      similar[:author] = node.at_xpath('./authors/author/name').content
      similar[:cover_url] = node.at_xpath('./image_url').content
      similar[:link] = node.at_xpath('./title').content
      similar[:work_id] = node.at_xpath('./id').content
      @booksimilar << similar
    end
    # raise @booksimilar.inspect
  end

  def add_to_bookbag

    if !Book.exists?(:gr_id => params[:id])
      Book.create({
        :title => params[:title],
        :author => params[:author],
        :cover_url => params[:cover_url],
        :isbn => params[:isbn],
        :description => params[:description],
        :work_id => params[:work_id],
        :gr_id => params[:id]
        })
    end

    @book = Book.where(:gr_id => params[:id]).first
    if !Bookbag.exists?(:book_id => @book.id, :user_id => current_user.id)
      Bookbag.create ({
        :book_id => @book.id,
        :user_id => current_user.id
        })
      @notice = "#{params[:title]} has been added to your Bookbag. How about another one?"
    else
      @notice = "#{params[:title]} has already been added to your Bookbag. How about a different book?"
    end
    redirect_to(detail_path(:id => params[:id]),:notice => @notice)
  end
end

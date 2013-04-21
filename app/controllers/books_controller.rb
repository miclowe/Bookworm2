require 'open-uri'

class BooksController < ApplicationController

  before_filter :authenticate_user!, :only => [:add_to_bookbag]

  def search
    @query = params[:query]
    # @books = BookSearch.new(@query).search

    url = "http://www.goodreads.com/search.xml?key=C9dGgAg4RNcn9xNhUVaMA&q=#{URI.escape@query}"
    d = Nokogiri::XML(open(url))

    @books = []
    d.xpath('//search/results/work').each {|node|

      book = {}
      
      book[:title] = node.at_xpath('./best_book/title').content
      book[:work_id] = node.at_xpath('./id').content
      book[:gr_id] = node.at_xpath('./best_book/id').content
      book[:author] = node.at_xpath('./best_book/author/name').content
      book[:pub_month] = node.at_xpath('./original_publication_month').content
      book[:pub_day] = node.at_xpath('./original_publication_day').content
      book[:pub_year] = node.at_xpath('./original_publication_year').content
      book[:sm_image_url] = node.at_xpath('./best_book/small_image_url').content

      @books << book
    }

    # *************************************************

    # url = "http://www.goodreads.com/search?query=#{URI.escape@query}"
    # d = Nokogiri::HTML(open(url))
    
    # raise d.inspect
    # @books = []
    
    # book = {}
    # book[:title] = d.css('.bookTitle').text.strip.gsub(/^$\n/, '').split(/\r?\n/)
    # book[:link] = d.css('a.bookTitle').map {|link| link['href']}
    # book[:author] = d.css('.authorName:nth-child(1) span').map { |name| name.text.gsub("</span>","") } # AuthorName
    
    # d.css('.leftContainer').each { |item|
    #   @books << book
    # }
    # raise @books.inspect 
    # *************************************************

  end

  def detail
    @id = params[:id]

    url = "http://www.goodreads.com/book/show/#{@id}"
    d = Nokogiri::HTML(open(url))
    # raise d.inspect

    @bookdetail = []
    
    detail = {}
    detail[:title] = d.at('meta[@property="og:title"]')[:content]
    # book[:title] = d.css('.bookTitle').text.strip.gsub("\n", ' ').gsub('"', '\"').gsub(/(\s){2,}/m, '\1')
    detail[:author] = d.css('.authorName:nth-child(1) span').first.text
    detail[:isbn] = d.at('meta[@property="good_reads:isbn"]')[:content]
    # book[:isbn] = d.css('#bookDataBox :nth-child(1) .infoBoxRowItem').text.strip.gsub('"', '\"').gsub(/(\s){2,}/m, '\1')
    detail[:description] = d.css('#description').text.strip.gsub('"', '\"').gsub(/(\s){2,}/m, '\1').gsub(/[^0-9]less[^0-9]/,'')
    detail[:image_url] = d.css('#imagecol img')[0]['src']
    detail[:work_id] = d.at('meta[@property="og:url"]')[:content].split(/\W+/)[6]

    d.css('.leftContainer').each { |item|
      @bookdetail << detail
    }
    # raise @bookdetails.inspect

    @booksimilar = []

    similar = {}
    similar[:title] = d.css('.bookBlurb .titleLink .title').map {|title| title.text}
    similar[:author] = d.css('.relatedWorks .authorName:nth-child(1) span').map {|author| author.text}
    similar[:image_url] = d.css('img[@origin=related_works]').map {|image| image['src']}
    similar[:link] = d.css('.titleLink a.title').map {|link| link['href']}
    similar[:work_id] = d.css('img[@origin=related_works]').map {|image| image['rel']}
    d.css('.rightContainer').each { |item|
      @booksimilar << similar
    }
    # raise @booksimilar.inspect

  end

  def similar
    @id = params[:id]

    url = "http://www.goodreads.com/book/similar/#{@id}"
    d = Nokogiri::HTML(open(url))
    # raise d.inspect
    @books = []
    
    book = {}
    book[:title] = d.css('.similarDescription')
    # book[:author] = d.css('.authorName:nth-child(1) span').first.text
    
    d.css('.leftContainer').each { |item|
      @books << book
    }
    
    # raise @books.inspect
  end

  def add_to_bookbag

    if !Book.exists?(:gr_id => params[:id])
      Book.create({
        :title => params[:title],
        :author => params[:author],
        :cover_url => params[:image_url],
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
      @notice = "#{params[:title]} already added to your Bookbag. How about different book?"
      # flash[:notice] => "Book already added to your Bookbag. How about different book?"
    end
    redirect_to(detail_path(:id => params[:id]),:notice => @notice)
  end
end

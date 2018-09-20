class MultisearchController < ApplicationController
  def index
    puts params[:query]
    @results = PgSearch.multisearch(params[:query])
    puts @results
  end
end

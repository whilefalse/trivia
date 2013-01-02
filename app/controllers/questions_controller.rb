class QuestionsController < ApplicationController
  before_filter :load_categories

  def index
  end

  def view
    category = params[:category]
    cat = Category.find_by_id(category)
    raise "Category not found: #{category}" unless cat
    @question = cat.next_question
  end

  private
  def load_categories
    @categories = Category.all
  end
end

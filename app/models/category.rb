class Category
  attr_accessor :id

  def initialize(id, questions)
    @id = id
    @questions = questions
  end

  def name
    I18n.t("questions.#{id}")
  end

  def next_question
    @questions.sample
  end

  def self.register(cat)
    (@categories ||= []) << cat
  end

  def self.all
    @categories || []
  end

  def self.find_by_id(id)
    return all.detect { |c| c.id.to_sym == id.to_sym }
  end
end

#Initialize categories
directory = File.expand_path('../../../config/questions', __FILE__)
question_files = Dir["#{directory}/*.txt"]

question_files.map do |qf|
  questions = File.readlines(qf).map do |q|
    Question.new(*q.sub('\n', '').split('*'))
  end
  Category.register(
    Category.new(File.basename(qf).sub('.txt', ''), questions)
  )
end

json.(@user, :id, :username, :created_at)
json.number_of_questions @questions.length
json.questions do
  json.array!(@questions) do |question|
    json.(question, :title, :id, :updated_at)
    json.number_of_answers question.answers.length
    json.has_accepted_answer question.has_accepted_answer?
  end
end
json.array!(@questions) do |question|
  json.asked_by User.find(question.user_id).username
  json.(question, :user_id, :title, :id, :updated_at)
  json.number_of_answers question.answers.length
  json.has_accepted_answer question.has_accepted_answer?
end
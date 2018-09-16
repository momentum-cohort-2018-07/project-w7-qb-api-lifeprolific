json.(@question, :id, :title, :body, :updated_at, :user_id)
json.asked_by User.find(@question.user_id).username
json.answers do
  json.array!(@answers.sort_by(&:score).reverse) do |answer|
    json.(answer, :id, :body, :updated_at, :score, :user_id)
    json.answered_by User.find(answer.user_id).username
    if @question.has_accepted_answer?
      json.accepted_answer @question.accepted_answer == answer
    else
      json.accepted_answer false
    end
  end
end
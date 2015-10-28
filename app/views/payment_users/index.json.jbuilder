json.array!(@payment_users) do |payment_user|
  json.extract! payment_user, :id
  json.url payment_user_url(payment_user, format: :json)
end

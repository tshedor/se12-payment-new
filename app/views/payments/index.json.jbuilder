json.array!(@payments) do |payment|
  json.extract! payment, :id, :title, :amount, :type_id, :note
  json.url payment_url(payment, format: :json)
end

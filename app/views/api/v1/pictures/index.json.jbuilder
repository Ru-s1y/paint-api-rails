json.meta do
  json.total_pages @pictures.total_pages
  json.current_page @pictures.current_page
end

json.pictures do
  json.array! @pictures do |picture|
    json.id picture.id
    json.name picture.name
    json.description picture.description
    json.publish picture.publish
    json.image picture.image
    json.created_at picture.created_at
    json.username picture.user.name
  end
end
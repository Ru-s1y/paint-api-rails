json.meta do
  json.total_pages @albums.total_pages
  json.current_page @albums.current_page
end

json.albums do
  json.array! @albums do |album|
    json.id album.id
    json.name album.name
    json.description album.description
    json.publish album.publish
    json.created_at album.created_at
    json.user_id album.user_id
    json.username album.user.name
  end
end
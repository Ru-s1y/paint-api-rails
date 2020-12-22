json.pictures do
  json.array! @pictures do |picture|
    json.id picture.id
    json.name picture.name
    json.description picture.description
    json.publish picture.publish
    json.image picture.image
    json.created_at picture.created_at
    json.album_name picture.album.name
  end
end

json.albums do
  json.array! @albums do |album|
    json.id album.id
    json.name album.name
    json.description album.description
    json.publish album.publish
    json.created_at album.created_at
  end
end
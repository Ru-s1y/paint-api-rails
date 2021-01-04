json.array! @album.pictures do |picture|
  json.id picture.id
  json.name picture.name
  json.description picture.description
  json.publish picture.publish
  json.image picture.image
  json.created_at picture.created_at
  json.username picture.user.name
end
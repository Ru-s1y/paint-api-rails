json.pictures do
  json.array! @favorite_pictures do |favoriteP|
    json.id favoriteP.picture.id
    json.name favoriteP.picture.name
    json.description favoriteP.picture.description
    json.image favoriteP.picture.image
    json.created_at favoriteP.created_at
  end
end

json.albums do
  json.array! @favorite_albums do |favoriteA|
    json.id favoriteA.album.id
    json.name favoriteA.album.name
    json.description favoriteA.album.description
    json.created_at favoriteA.created_at
  end
end
json.pictures do
  json.array! @favorite_pictures do |favoriteP|
    json.id favoriteP.picture.id
    json.name favoriteP.picture.name
    json.description favoriteP.picture.description
    json.image favoriteP.picture.image
    json.created_at favoriteP.created_at
    json.username favoriteP.picture.user.name
  end
end
json.array! @stores do | store|
  json.id store.id
  json.title store.title
  json.city store.city
  json.street store.street
  json.spaces_count store.spaces_count
end

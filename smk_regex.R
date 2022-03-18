library(mongolite)
library(data.table)
library(ggplot2)


con <-mongo(
  collection = "artworks",
  db = "smk",
  url = "mongodb://localhost",
  verbose = TRUE
)

artworksAll <- con$find(
  query = '{"acquisition_date":{"$gte":"1895-01-01T00:00:00Z"},
  "object_number":{ "$regex" : "KMS*.", "$options" : "i"}}',
  fields = '{
  "_id":1,
  "object_number":1,
  "title": {"$first":"$titles.title"},
  "acquisition_date":1,
  "creator": {"$first":"$production.creator"},
  "gender": {"$first":"$production.creator_gender"}}',
  limit=100
)

artworksAll <- na.omit(artworksAll)

artworksAll$year <- year(artworksAll$acquisition_date)

hist(artworksAll$year)
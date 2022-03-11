library(mongolite)

con <-mongo(
  collection = "rest",
  db = "dining2",
  url = "mongodb://localhost",
  verbose = TRUE
)

restorig <- con$find(limit=10)

numt=2
for (i in 1:ncol(rests)) {
  numt<-numt*0.95
  rests[i,"Viggo"]=numt[1]
}

for (i in 1:ncol(rests)) {
  key <- rests[i,6]
  val <- rests[i,9]
  con$update(
    query=paste0('{"restaurant_id": "',key,'"}'),
    update=paste0('{"$set":{"lbl": "',val,'"}}')
  )
}

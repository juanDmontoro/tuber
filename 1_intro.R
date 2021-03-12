library(tuber)
library(tidyverse)
library(purrr)
client_id <-
client_secret <- 
yt_oauth(app_id=client_id,app_secret = client_secret,token='')



# 1. Básicos: identificar canal y lista de reproduccion -------------------
# Primavera Sound YouTube channel includes  lots of re
# Seleccionar INFO de una lista de reproducción.
# el code de la lista aparece tras "list=...."
# lista de reproducción con 13 videos
# https://www.youtube.com/watch?v=4JcENw71M6c&list=PLcKRu3rQFeZHih8_9EnWe7BpIMyUtM21N
# glastonbury in BBC: rap
# https://www.youtube.com/watch?v=Sq3w76WOYmM&list=PLlJ6mcpK7uj7BKTsoosZiEaaVikolucnj
# david chapelle
# "https://www.youtube.com/playlist?list=PLG6HoeSC3raE-EB8r_vVDOs-59kg3Spvd"

# 1. collect the videos of a list into a dataframe ()
primaveraRaw <- tuber::get_playlist_items(filter=c(playlist_id="PLcKRu3rQFeZHih8_9EnWe7BpIMyUtM21N"))
chapelleRaw <- tuber::get_playlist_items(filter=c(playlist_id=dave_chappelle_playlist_id),part="contentDetails",
                                          max_results =200 ) #if not indicated max number of videos is 50
bbcRaw <- tuber::get_playlist_items(filter=c(playlist_id="PLlJ6mcpK7uj7BKTsoosZiEaaVikolucnj"))

# 2. Collecting information from a Youtube playlist

# Generamos los video ids
primavera_vid_id <- base::as.vector(primaveraRaw$contentDetails.videoId)
glimpse(primavera_vid_id)
primavera_vid_id[[1]]

# create function to obtain stats
get_all_stats <- function(id){
  tuber::get_stats(video_id = id)
}
# create function to obtain videoDetails
get_details <- function(id){
  tuber::get_video_details(video_id = id)
}

# return the caption of the video (it does not seem to work)
get_captions(video_id =)

# get comment threads
thread1 <- get_comment_threads(c(video_id="4JcENw71M6c"))
get_comment_threads(c(video_id="4JcENw71M6c"))

get_All_Comments <- function(vid_id){
  get_comment_threads(c(video_id=vid_id))
  }


#use purr to iterate the above functions
# map_df devuelve siempre un DF
primaveraAllStats <- map_df(.x=primavera_vid_id,.f=get_all_stats)
primaveraAllStats%>%glimpse()
# para obtener los detalles del video map_df() no funcionaría, ya que el objeto que devuelve es una lista no un DF
# en ese caso aplicamos map() que devuelve una lista
primaveraDetails <- map(.x=primavera_vid_id,.f=get_details)

primaveraComments <- map(.x=primavera_vid_id,.f=get_All_Comments)
get_comment_threads(c(video_id=primavera_vid_id[[3]]),simplify = T)
get_captions(primavera_vid_id[[3]])


# diferencias entre get_all_comments y get_threads

comment1 <- get_all_comments(primavera_vid_id[[1]])
thread1 <- get_comment_threads(c(videoprimavera_vid_id[[1]]))
# en principio parece que la info de comments es mas completa que la de threads!

#
# Examples by coder
#
ans <- lapply(list("zdnybX_qWxY", "zdnybX_qWxY"), get_all_comments)
ldply(ans, rbind)

lapply(primavera_vid_id %>%list(),get_all_comments)

primavera_vid_id %>%str

mymap(primavera_vid_id ,get_all_comments)
get_all_comments(primavera_vid_id[[1]])

# 
# 
# 
# objDataFarm <- syntheticDataCreator()
# EL <- objDataFarm$cohort.RT()
# EL <- data.frame(EL)
# EL$ID <- as.numeric(EL$ID)
# EL$Event <- as.character(EL$Event)
# EL$Date <- as.character(EL$Date)
# 
# objDL <- dataLoader()
# objDL$load.data.frame(mydata = EL,IDName = "ID",EVENTName = "Event",dateColumnName = "Date",format.column.date = "%Y-%m-%d")
# out.objDL <- objDL$getData()
# 
# arr.eventi <- out.objDL$arrayAssociativo[which(!(out.objDL$arrayAssociativo %in% c("BEGIN","END")))]
# n.arr.eventi <- length(arr.eventi)
# 
# arr.n.stories <- c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20)
# 
# # costruisci la griglia
# plot(c(),xlim=c(0,n.arr.eventi), ylim=c(0,100) )
# for( i in 1:n.arr.eventi ) {
#   points( c(i,i), c(10,90), type='l', col="grey")
#   y.pos.txt <- 0
#   if((i %% 2) == 0) y.pos.txt <- 100
#   text( x = i, y = y.pos.txt, arr.eventi[i])
# }
# 
# # plotta le storie
# 
# y.start <- 100; y.step <- 5; y.delta.between.stories <- 10
# y.current <- y.start
# lwd = 2
# 
# # fai una stima del y.delta.between.stories ottimale
# total.jump <- 0
# for(n.stories in arr.n.stories ) {
#   arr.evt <- as.character(unlist(out.objDL$wordSequence.raw[n.stories]))
#   total.jump <- total.jump + length(arr.evt)
# }
# 
# y.step <- 70 / total.jump
# y.delta.between.stories <- y.step * 2
# down.counter <- 0
# 
# # fai una stima del y.delta.between.stories ottimale
# for(n.stories in arr.n.stories ) {
#   sequenza <- as.character(unlist(out.objDL$wordSequence.raw[n.stories])); n.sequenza <- length(sequenza)
#   direction <- ""; old.direction <- ""
#   for(i in 1:(n.sequenza-1)) {
#     evento <- sequenza[i]
#     evento.next <- sequenza[i+1]    
#     if( which( arr.eventi == evento.next) > which( arr.eventi == evento)) direction <- "dx"
#     if( which( arr.eventi == evento.next) < which( arr.eventi == evento)) direction <- "sx"
#     if( i == 1 ) {
#       x.pos <- which(arr.eventi == evento);     y.pos <- y.current      
#       x.pos.target <- which(arr.eventi == evento.next);       y.pos.target <- y.current
#       if( evento.next == evento ) { next; }
#       old.direction <- direction
#       next;
#     }
#     if( evento.next == evento ) {    next;  }
#     if( direction != old.direction & old.direction!="") {
#       y.pos.down <- y.current-y.step
#       down.counter <- down.counter + 1
#       y.current <- y.pos.down
#     }
#     x.pos <- which(arr.eventi == evento);     y.pos <- y.current      
#     x.pos.target <- which(arr.eventi == evento.next);       y.pos.target <- y.current
#     old.direction <- direction
#   }
#   y.current <- y.current - y.delta.between.stories
# }
# # for(n.stories in arr.n.stories ) {
# #   arr.evt <- as.character(unlist(out.objDL$wordSequence.raw[n.stories]))
# #   n.arr.evt <- length(arr.evt)
# #   for(i in 1:(n.arr.evt-1)) {
# #     evento <- arr.evt[i]
# #     evento.next <- arr.evt[i+1]
# #     if( evento.next == evento ) next;
# #     if(which( arr.eventi == evento.next) > which( arr.eventi == evento)) next;  
# # 
# #     # move.down
# #     down.counter <- down.counter + 1
# #   }
# # }
# 
# 
# # plotta le storie
# y.start <- 90; 
# y.min.bottom <- 10
# y.current <- y.start
# lwd = 2
# 
# 
# y.step <- (y.start-y.min.bottom) / (down.counter + 2 * length(arr.n.stories))
# y.delta.between.stories <- y.step * 2
# down.counter <- 0
# 
# for(n.stories in arr.n.stories ) {
#   
#   sequenza <- as.character(unlist(out.objDL$wordSequence.raw[n.stories])); n.sequenza <- length(sequenza)
#   direction <- ""; old.direction <- ""
#   for(i in 1:(n.sequenza-1)) {
#     evento <- sequenza[i]
#     evento.next <- sequenza[i+1]    
#     
#     if( which( arr.eventi == evento.next) > which( arr.eventi == evento)) direction <- "dx"
#     if( which( arr.eventi == evento.next) < which( arr.eventi == evento)) direction <- "sx"
#     
#     if( i == 1 ) {
#       x.pos <- which(arr.eventi == evento);     y.pos <- y.current      
#       x.pos.target <- which(arr.eventi == evento.next);       y.pos.target <- y.current
#       points(  c(x.pos,x.pos.target) , c(y.pos.target,y.pos.target) , type='l' , lwd = lwd )
#       points(  x.pos , y.pos.target ,pch=20 )
#       points(  x.pos.target , y.pos.target ,pch=20 )
#       if( evento.next == evento ) { next; }
#       arrows( x0 = x.pos,x1 = x.pos.target , y0 = y.pos.target,y1 = y.pos.target, lwd = lwd,length = 0.1)      
#       old.direction <- direction
#       next;
#     }
#     
#     if( evento.next == evento ) {
#       points(  x.pos.target , y.pos.target , pch=1 , cex = 3)
#       next;
#     }
#     
#     if( direction != old.direction & old.direction!="") {
#       y.pos.down <- y.current-y.step
#       down.counter <- down.counter + 1
#       points(  c(x.pos.target,x.pos.target) , c(y.current,y.pos.down) , type='l' , lwd = lwd )
#       points(  x.pos.target , y.pos.down , pch=20, lwd = lwd )
#       y.current <- y.pos.down
#     }
#     
#     x.pos <- which(arr.eventi == evento);     y.pos <- y.current      
#     x.pos.target <- which(arr.eventi == evento.next);       y.pos.target <- y.current
#     points(  c(x.pos,x.pos.target) , c(y.pos.target,y.pos.target) , type='l' , lwd = lwd )
#     points(  x.pos.target , y.pos.target ,pch=20 )
#     arrows( x0 = x.pos,x1 = x.pos.target , y0 = y.pos.target,y1 = y.pos.target, lwd = lwd,length = 0.1)  
#     
#     old.direction <- direction
#   }
#   y.current <- y.current - y.delta.between.stories
# }


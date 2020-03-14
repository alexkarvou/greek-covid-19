library(mongolite)
#connection with encoded password
collection<-mongo(db='ker-app',collection =
        'karvou_play',url=
        "mongodb+srv://ker-webapp:wannabe80%25@devdb-7hq34.gcp.mongodb.net/test?retryWrites=true",
        verbose=TRUE)
#general stuff
collection$count()
#
collection$iterate()$one()
collection$find('{ "first name ": "alex"}')

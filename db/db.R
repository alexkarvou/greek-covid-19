
library(mongolite)
#connection with encoded password
collection<-mongo(db='greek-covid-19',
                collection ='Entries',
                url="mongodb+srv://greekcovid19:greekcovid19@cluster0-vqe01.gcp.mongodb.net/test",
        verbose=TRUE)

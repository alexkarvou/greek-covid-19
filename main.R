library(shiny)
library(shinydashboard)
library(timevis)
library(rsconnect)
library(argparse)

# Argument parsing
parser<-ArgumentParser()
parser$add_argument("-mode",default="local")
args<-parser$parse_args()

# Authorize
setAccountInfo(name='chris-fotis',
			  token='7BB2FD8EE0D82F7A2A8C0BCEEB84FB36',
			  secret='3NXitayguu4ecZvydBeJbIdaFEon8MFW9pPkQNxX')


if(args$mode=="local"){
  runApp()
} else if(args$mode=="deploy"){
  deployApp()
}

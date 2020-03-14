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
setAccountInfo(name='greek-covid-19',
			  token='D13BF982482782EB8F24FA6C09D4661C',
			  secret='ih8Oa3FOe/4rPZgrlP8mC/7DbkNCudnBFTZ9qQym')


if(args$mode=="local"){
  runApp()
} else if(args$mode=="deploy"){
  deployApp()
}

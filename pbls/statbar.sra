HA$PBExportHeader$statbar.sra
$PBExportComments$Generated Application Object
forward
global type statbar from application
end type
global transaction sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global message message
end forward

global type statbar from application
string appname = "statbar"
end type
global statbar statbar

on statbar.create
appname="statbar"
message=create message
sqlca=create transaction
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on statbar.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;open (w_statbar)
end event


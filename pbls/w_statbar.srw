HA$PBExportHeader$w_statbar.srw
forward
global type w_statbar from window
end type
type cb_2 from commandbutton within w_statbar
end type
type cb_1 from commandbutton within w_statbar
end type
end forward

global type w_statbar from window
integer width = 2971
integer height = 2004
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
end type
global w_statbar w_statbar

type variables
PRIVATE:

n_cst_winsrv_response_resize_srv		inv_response_resize
n_cst_winsrv_native_statusbar_srv	inv_statusbar
end variables

on w_statbar.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.cb_1}
end on

on w_statbar.destroy
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;//////////////////////////////////////////////////////////////////////////////
// Description: 
// Initialize
// 
// Author: 
// B.Kemner, 17.12.2014 
//

inv_response_resize = create n_cst_winsrv_response_resize_srv
inv_response_resize.of_setRequestor(this)

inv_statusbar = create n_cst_winsrv_native_statusbar_srv
inv_statusbar.of_setRequestor(this)

return 0
end event

event resize;//////////////////////////////////////////////////////////////////////////////
// Description: 
// Triggers pfc_resize of service.
// 
// Author: 
// B.Kemner, 17.12.2014 
// 
// Arguments: 
// siztype 		unsignedlong 	Sizetype
// newwidth 	integer 			Width
// newheight 	integer			Height
// 
// Returns: 
//

if isValid(inv_statusbar) then
	inv_statusbar.event pfc_resize(sizetype, newwidth, newheight)
end if
end event

type cb_2 from commandbutton within w_statbar
integer x = 2487
integer y = 1664
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancel"
end type

type cb_1 from commandbutton within w_statbar
integer x = 2048
integer y = 1664
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "OK"
end type


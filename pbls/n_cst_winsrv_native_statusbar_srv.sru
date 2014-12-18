HA$PBExportHeader$n_cst_winsrv_native_statusbar_srv.sru
forward
global type n_cst_winsrv_native_statusbar_srv from nonvisualobject
end type
end forward

global type n_cst_winsrv_native_statusbar_srv from nonvisualobject
event pfc_resize ( long al_sizetype,  long al_width,  long al_height )
end type
global n_cst_winsrv_native_statusbar_srv n_cst_winsrv_native_statusbar_srv

type prototypes
Function long CreateWindowEx( ulong dwExStyle, String lpClassName, String lpWindowName, ulong dwStyle, long xPos, long yPos, long nWidth, long nHeight, long hWndParent, long hMenu, long hInstance, long lpParam ) Library "user32" Alias For "CreateWindowExW" 
Function long GetDlgItem(ulong hDlg, long nIDDlgItem) Library "user32"
end prototypes

type variables
PRIVATE:

window	iw_requestor
end variables

forward prototypes
public subroutine of_setrequestor (window aw_requestor)
public subroutine of_setstatusbar ()
end prototypes

event pfc_resize(long al_sizetype, long al_width, long al_height);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Sends the resize event to the native status bar.
// 
// Author: 
// B.Kemner, 17.12.2014 
// 
// Arguments: 
// al_sizetype long	Size type
// al_width 	long	Width
// al_height 	long	Height
//

Send(GetDlgItem(handle(iw_requestor), 103), 5, 0, 0);
end event

public subroutine of_setrequestor (window aw_requestor);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Sets the requestor to this service.
// 
// Author: 
// B.Kemner, 17.12.2014 
// 
// Arguments: 
// aw_requestor 	window	Requestor window for this service
//

iw_requestor = aw_requestor
this.of_setStatusBar()



end subroutine

public subroutine of_setstatusbar ();//////////////////////////////////////////////////////////////////////////////
// Description: 
// Create the statusbar
// 
// Author: 
// B.Kemner, 17.12.2014 
// 
//

string	ls_null
long		ll_null
long		ll_style = 1342177536

setNull(ls_null)
setNull(ll_null)

CreateWindowEx(0, "msctls_statusbar32", ls_null, ll_style, 0, 0, 0, 0, handle(iw_requestor), 103, handle(getApplication()), ll_null)


end subroutine

on n_cst_winsrv_native_statusbar_srv.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_winsrv_native_statusbar_srv.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


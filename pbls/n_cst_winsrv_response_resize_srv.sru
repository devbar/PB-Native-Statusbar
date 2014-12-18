HA$PBExportHeader$n_cst_winsrv_response_resize_srv.sru
$PBExportComments$Service to make a response window resizeable
forward
global type n_cst_winsrv_response_resize_srv from nonvisualobject
end type
end forward

global type n_cst_winsrv_response_resize_srv from nonvisualobject
end type
global n_cst_winsrv_response_resize_srv n_cst_winsrv_response_resize_srv

type prototypes
Function longlong GetWindowLongW (long hWindow, integer nIndex) Library "user32.dll"  
Function longlong SetWindowLongW (long hWindow, integer nIndex, long dwNewLong) library "user32.dll"  
Function ulong GetSystemMenu(ulong hWnd, boolean bRevert) library "user32.dll"
Function long InsertMenuW(uLong hMenu, uint uPosition, uint uFlags, uint uIDNewItem, String lpNewItem) library "user32.dll"
Function long DrawMenuBar(ulong hWnd) library "user32.dll"
Function long SetWindowPos(long hWnd, long hWndInsertAfter, int newX, int newY, int newWidth, int newHeight, uint uFlags) library "user32.dll"

end prototypes
type variables
PRIVATE:

CONSTANT int GWL_STYLE = -16
CONSTANT uint SWP_NOSIZE = 1
CONSTANT uint SWP_NOMOVE = 2
CONSTANT uint SWP_NOZORDER  = 4
CONSTANT uint SWP_FRAMECHANGED = 32
CONSTANT ulong WS_SYSMENU = 524288
CONSTANT ulong WS_THICKFRAME = 262144
CONSTANT ulong WS_MAXIMIZEBOX = 65536
CONSTANT ulong WS_MINIMIZEBOX = 131072
CONSTANT uint SC_RESTORE = 61728
CONSTANT uint SC_MAXIMIZE = 61488
CONSTANT uint SC_MINIMIZE = 61472
CONSTANT uint SC_SIZE = 61440
CONSTANT uint MF_BYCOMMAND = 0
CONSTANT uint MF_STRING = 0
CONSTANT uint MF_BYPOSITION = 1024

long		il_orig_width
long		il_orig_height
window	iw_requestor

end variables

forward prototypes
private subroutine of_setresizeable ()
public subroutine of_setrequestor (window aw_requestor)
end prototypes

private subroutine of_setresizeable ();//////////////////////////////////////////////////////////////////////////////
// Description: 
// Initializes the ability to resize to this response window.
// 
// Author: 
// B.Kemner, 17.12.2014 
//

ulong     ll_style, ll_hMenu, ll_hWnd, ll_newstyle

ll_hWnd = handle(iw_requestor)

// Save the original size of the window
il_orig_width = iw_requestor.width
il_orig_height = iw_requestor.height

// Get the current window style
ll_style = GetWindowLongW(handle(iw_requestor), GWL_STYLE)

// Thickframe to enable resize
ll_newstyle = ll_style + WS_THICKFRAME + WS_MAXIMIZEBOX

if ll_style <> 0 then
    if SetWindowLongW ( ll_hWnd, GWL_STYLE, ll_newstyle ) <> 0 then

			// Get a handle to the system menu
			ll_hMenu = GetSystemMenu( ll_hWnd, false )

			if ll_hMenu > 0 then
				 InsertMenuW( ll_hMenu, 1, MF_BYPOSITION + MF_STRING, SC_MAXIMIZE, "Maximize" ) ;
				 InsertMenuW( ll_hMenu, 1, MF_BYPOSITION + MF_STRING, SC_RESTORE, "Restore" ) ;

				 // The Size menu option has to be added to allow the resize gripper to work
				 // if there is a control menu

				 InsertMenuW( ll_hMenu, 1, MF_BYPOSITION + MF_STRING, SC_SIZE, "Size" ) ;
				 DrawMenuBar( ll_hWnd )
			end if

        //Force a repaint
        SetWindowPos ( ll_hWnd, 0, 0, 0, 0, 0, SWP_NOSIZE + SWP_NOMOVE + SWP_NOZORDER + SWP_FRAMECHANGED )

        iw_requestor.SetRedraw(false)

	end if

end if

return 
end subroutine

public subroutine of_setrequestor (window aw_requestor);//////////////////////////////////////////////////////////////////////////////
// Description: 
// Sets the requestor to this service.
// 
// Author: 
// B.Kemner, 17.12.2014 
// 
// Arguments: 
// adw_requestor 	window	Requestor window
// 
//

iw_requestor = aw_requestor
this.of_setResizeable()
end subroutine

on n_cst_winsrv_response_resize_srv.create
call super::create
TriggerEvent( this, "constructor" )
end on

on n_cst_winsrv_response_resize_srv.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on


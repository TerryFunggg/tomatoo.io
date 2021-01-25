checkBrowserSupportNotify = -> 'Notification' in window

checkPermissionEnabled = ->
    Notification.permission isnt 'granted' and Notification.permission isnt 'denied'

permissionIsGranted = ( permission ) -> permission is 'granted'

enableNotify = ->
    if checkBrowserSupportNotify and checkPermissionEnabled
        Notification.requestPermission().then( permissionIsGranted )

send = (msg) -> new Notification(msg)

export {
        enableNotify,
        send
}

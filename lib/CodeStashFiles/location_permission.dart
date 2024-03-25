Instruction
 /*
 This is location request permission function it used for allow location permission for the app
 1. "permission_handler" package used for this.
 2. It return bolean value either isGranted or isDenied 
 3. If user denied the request the the defualt function openAppSetting will be open 
 */
Future<bool> ifPermissions(BuildContext context) async {
  var locationPermission = await Permission.location.request();

  if (locationPermission.isGranted) {
    return true;
  } else if (locationPermission.isDenied) {
    // await Permission.location.request();
    openAppSettings();
    return false;
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Location permission permanently denied. Please enable it in app settings.'),
      ),
    );
    openAppSettings();
    return false;
  }
}

// You can call it like this 

if (await ifPermissions(context)) {
          // Do this 
        }else{
 // Do This
        }

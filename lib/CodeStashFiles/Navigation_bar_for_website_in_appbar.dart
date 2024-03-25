Instruction
// No need any external package or library
// make a separate class for navigation bar
// past the below code
// May be you get error due to google fonts then you have to remove google font style or add google font package in pubspec.yaml file
// if you get error on navigation in Material page rout then replace your actual screens names in the routs in each inkwell on tap function.
// after this call this class in the child of action of app bar of any screen
// enjoy the navigation bar in top of website



import 'package:flutter/material.dart';

class AppNavigationBar extends StatefulWidget {
  const AppNavigationBar({super.key});

  @override
  State<AppNavigationBar> createState() => _AppNavigationBarState();
}

class _AppNavigationBarState extends State<AppNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
        child: Row(
          children: [
            // Home Page
            InkWell(
                    hoverColor: secondaryColor2,
                    borderRadius: BorderRadius.circular(10),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return HomePage();
                      }));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(
                        child: Text(
                          "Home",
                          style: GoogleFonts.poppins(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      decoration: BoxDecoration(
                        //color: isHovered ? Colors.red : Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  )
                
            // shop Page
            InkWell(
              hoverColor: secondaryColor2,
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ShopPage();
                }));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    "Shope",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  //color: isHovered ? Colors.red : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            // Video Page
            InkWell(
              hoverColor: secondaryColor2,
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return VideosPage();
                }));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    "Videos",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  //color: isHovered ? Colors.red : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            // Info Page
            InkWell(
              hoverColor: secondaryColor2,
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return InfoPage();
                }));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    "Info",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  //color: isHovered ? Colors.red : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            // Incription Page
            InkWell(
              hoverColor: secondaryColor2,
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return InscriptionPage();
                }));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    "Incription",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  //color: isHovered ? Colors.red : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
            // Language Page
            InkWell(
              hoverColor: secondaryColor2,
              borderRadius: BorderRadius.circular(10),
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return Langue();
                }));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Center(
                  child: Text(
                    "Language",
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                  //color: isHovered ? Colors.red : Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(
              width: 5,
            ),
           
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:weather_app_julian/utils/size_desing.dart';

class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: LayoutBuilder(
          builder: (context, constraints) {
            Responsive size = Responsive(context);
            return SizedBox(
              width: size.width,
              height: size.height,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "CLIMANOW",
                      style: TextStyle(
                        color: const Color(0xff54A8FF),
                        fontSize: size.height * 0.06,
                        fontFamily: "Kavoon",
                      ),
                    ),
                    Image.asset("assets/images/getStarted.png"),
                    GestureDetector(
                      onTap:() => Navigator.pushReplacementNamed(context, "home"),
                      child: Container(
                        height: size.height * 0.07,
                        width: size.width * 0.75,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: const Color(0xffFFD439),
                        ),
                        child: Center(
                          child: Text(
                            "INICIAR",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: size.height * 0.03,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "JULIAN HERNANDEZ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: size.height * 0.02,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

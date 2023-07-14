import '../export.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive(context);
    final isLargeScreen = size.width > 600;

    return GestureDetector(
      onTap: () => showSearch(context: context, delegate: CitySearchDelegate()),
      child: Container(
        
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.only(left: 20),
        width: isLargeScreen ? size.width * 0.5 :size.width * 0.9,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xA795B4F7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: const [
                Image(
                  width: 50,
                  image: AssetImage("assets/images/searchstatus.png"),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Explora otras partes",
                  style: TextStyle(fontSize: 16, color: Colors.black26),
                )
              ],
            )),
      ),
    );
  }
}

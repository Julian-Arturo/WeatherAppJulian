


import '../export.dart';

class ResultCard extends StatefulWidget {
  String city;
  final bool? isSelected;
  final ValueChanged<bool>? onSelected;

  ResultCard({
    Key? key,
    required this.city,
    this.isSelected,
    this.onSelected,
  }) : super(key: key);

  @override
  _ResultCardState createState() => _ResultCardState();
}

class _ResultCardState extends State<ResultCard> {
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    loadCheckboxState();
    isChecked = widget.isSelected!;
  }

  void loadCheckboxState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? savedState = prefs.getBool(widget.city);
    if (savedState != null) {
      setState(() {
        isChecked = savedState;
      });
    }
  }

  void saveCheckboxState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(widget.city, value);
  }

  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: size.width * 0.9,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(112, 158, 158, 158),
            blurRadius: 5,
            spreadRadius: 2,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Checkbox(
              value: isChecked,
              onChanged: (value) {
                setState(() {
                  isChecked = value ?? false;
                });
                widget.onSelected!(isChecked);
              },
            ),
          ),
          Text(
            widget.city,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

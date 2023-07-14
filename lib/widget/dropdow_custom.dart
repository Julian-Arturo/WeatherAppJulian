

import '../export.dart';

class DropdownCustom extends StatefulWidget {
  const DropdownCustom({super.key});

  @override
  State<DropdownCustom> createState() => _DropdownCustomState();
}

class _DropdownCustomState extends State<DropdownCustom> {
  @override
  Widget build(BuildContext context) {
    Responsive size = Responsive(context);
        final isLargeScreen = size.width > 600;

    final responsecity = Provider.of<LogicController>(context);
    List<String> selectedCities = responsecity.getSelectedCities();
    String? selectedCity;
    return selectedCities.isNotEmpty
        ? SizedBox(
            width: isLargeScreen ? size.width * 0.3 :size.width * 0.8,
            child: DropdownButtonFormField<String>(
                value: selectedCity,
                onChanged: (String? newValue) {
                  setState(() {
                    responsecity.getDataCity(newValue);
                    selectedCity = newValue;
                  });
                },
                decoration: InputDecoration(
                  hintText: selectedCities[0],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  filled: true,
                  fillColor: const Color(0xff67E1D2),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                ),
                items: selectedCities.map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(
                      city,
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList()),
          )
        : const AddFavorites();
  }
}

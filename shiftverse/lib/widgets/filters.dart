import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shiftverse/controllers/sheetsController.dart';
import 'package:shiftverse/widgets/shift_list.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  //bool forYouFilter = true;
  bool stPerpetuaFilter = true;
  bool stMarcellino = false;
  bool stSylvester = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<SheetsController>(
      builder: (context, value, child) => Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 145),
            child: Wrap(
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(right: 20),
                //   child: FilterChip(
                //     showCheckmark: true,
                //     backgroundColor: forYouFilter
                //         ? Theme.of(context).colorScheme.tertiary
                //         : Theme.of(context).colorScheme.secondary,
                //     label: Text(
                //       'For You',
                //       style: Theme.of(context)
                //           .textTheme
                //           .labelMedium!
                //           .copyWith(color: Theme.of(context).colorScheme.onSecondary),
                //     ),
                //     onSelected: (_) {
                //       setState(() {
                //         forYouFilter = !forYouFilter;
                //       });

                //     },
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: FilterChip(
                    showCheckmark: stPerpetuaFilter,
                    backgroundColor: stPerpetuaFilter
                        ? Theme.of(context).colorScheme.tertiary
                        : Theme.of(context).colorScheme.secondary,
                    label: Text(
                      'St. Perpetua',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    onSelected: (_) {
                      setState(() {
                        stPerpetuaFilter = !stPerpetuaFilter;
                      });
                      if (stPerpetuaFilter == true) {
                        value.addJumuiya('ST PERPETUA');
                      } else {
                        value.removeJumuiya('ST PERPETUA');
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: FilterChip(
                    showCheckmark: stMarcellino ? true : false,
                    backgroundColor: stMarcellino
                        ? Theme.of(context).colorScheme.tertiary
                        : Theme.of(context).colorScheme.secondary,
                    label: Text(
                      'St. Marcellino',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    onSelected: (_) {
                      setState(() {
                        stMarcellino = !stMarcellino;
                      });
                      if (stMarcellino == true) {
                        value.addJumuiya('ST MARCELLINO');
                      } else {
                        value.removeJumuiya('ST MARCELLINO');
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: FilterChip(
                    showCheckmark: stSylvester ? true : false,
                    backgroundColor: stSylvester
                        ? Theme.of(context).colorScheme.tertiary
                        : Theme.of(context).colorScheme.secondary,
                    label: Text(
                      'St. Sylvester',
                      style: Theme.of(context).textTheme.labelMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary),
                    ),
                    onSelected: (_) {
                      setState(() {
                        stSylvester = !stSylvester;
                      });
                      if (stSylvester == true) {
                        value.addJumuiya('ST SYLVESTER');
                      } else {
                        value.removeJumuiya('ST SYLVESTER');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ShiftList(
            sheet: value,
          )
        ],
      ),
    );
  }
}

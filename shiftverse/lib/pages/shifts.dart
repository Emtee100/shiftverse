import 'package:flutter/material.dart';

class Shifts extends StatelessWidget {
  const Shifts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            Text(
              'Shifts',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 15),
            ConstrainedBox(
              constraints: const BoxConstraints(maxHeight: 145),
              child: Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: FilterChip(
                      color: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.secondary),
                      label: Text(
                        'For You',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                      ),
                      onSelected: (value) => print(value),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: FilterChip(
                      color: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.secondary),
                      label: Text(
                        'St. Perpetua',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                      ),
                      onSelected: (value) => print(value),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: FilterChip(
                      color: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.secondary),
                      label: Text(
                        'St. Mercelino',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                      ),
                      onSelected: (value) => print(value),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: FilterChip(
                      color: WidgetStatePropertyAll(
                          Theme.of(context).colorScheme.secondary),
                      label: Text(
                        'St. Sylvester',
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium!
                            .copyWith(
                                color:
                                    Theme.of(context).colorScheme.onSecondary),
                      ),
                      onSelected: (value) => print(value),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15,),
            SizedBox(
                height: 800,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            tileColor: Theme.of(context)
                                .colorScheme
                                .surfaceContainerLow,
                            leading: const Icon(Icons.contact_page),
                            title: const Text('Jumuiya: St.Sylvester'),
                            subtitle: const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Mark Thomas'),
                                Text('Mary Akinyi')
                              ],
                            )),
                      );
                    })),
          ],
        ),
      ),
    ));
  }
}

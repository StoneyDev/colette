import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../data/demos.dart';
import 'activity_infos.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      body: SafeArea(
        child: ListView.separated(
          itemCount: Demos.activities().length,
          padding: const EdgeInsets.all(15),
          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => ActivityInfos(
                    activity: Demos.activities()[index],
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Image
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade400,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    height: 150,
                  ),

                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Title
                            Text(
                              Demos.activities()[index].title,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),

                            const SizedBox(height: 5),

                            // Title
                            Text(DateFormat('dd/MM/y à HH:mm').format(Demos.activities()[index].startDate)),

                            const SizedBox(height: 5),

                            // Maximum attendees
                            Text('${Demos.activities()[index].attendees} personnes'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

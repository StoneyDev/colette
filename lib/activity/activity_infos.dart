import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../models/activity.dart';
import 'cubit/activity_cubit.dart';

class ActivityInfos extends StatefulWidget {
  const ActivityInfos({required this.activity, super.key});

  final Activity activity;

  @override
  State<ActivityInfos> createState() => _ActivityInfosState();
}

class _ActivityInfosState extends State<ActivityInfos> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ActivityCubit>(
      create: (BuildContext context) => ActivityCubit(activityId: widget.activity.id, userId: '1'),
      child: BlocConsumer<ActivityCubit, ActivityState>(
        listener: (BuildContext context, ActivityState state) {
          if (state is SubscribeSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Super, votre participation a bien été prise en compte'),
              ),
            );
          } else if (state is UnsubscribeSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Votre désinscription a bien été prise en compte :('),
              ),
            );
          }
        },
        builder: (BuildContext context, ActivityState state) {
          return Scaffold(
            appBar: AppBar(),
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.all(15),
                children: <Widget>[
                  // Date
                  Row(
                    children: <Widget>[
                      const Icon(Icons.calendar_month),
                      const SizedBox(width: 10),
                      Text(DateFormat('dd/MM/y à HH:mm').format(widget.activity.startDate))
                    ],
                  ),

                  const SizedBox(height: 15),

                  // Attendees
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Icon(Icons.group),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${widget.activity.attendees} participants'),
                          const SizedBox(height: 5),
                          Text(
                            '${widget.activity.attendees - state.remainingPlaces} places restantes',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.black45,
                                ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
            bottomSheet: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: ElevatedButton(
                      child: Text(state is ActivityUnsubscriber ? "S'inscrire" : 'Se désinscrire'),
                      onPressed: () async {
                        final ActivityCubit activityCubit = context.read<ActivityCubit>();

                        state is ActivityUnsubscriber ? activityCubit.subscribe() : activityCubit.unsubscribe();
                      },
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

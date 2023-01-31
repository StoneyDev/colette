import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../user/cubit/user_cubit.dart';
import 'activity_infos.dart';
import 'cubit/activity_cubit.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({super.key});

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> with SingleTickerProviderStateMixin {
  static const List<Tab> tabs = <Tab>[
    Tab(text: 'Tous'),
    Tab(text: 'Mes activités'),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (BuildContext context, UserState state) {
        return BlocProvider<ActivityCubit>(
          create: (BuildContext context) => ActivityCubit(user: (state as AuthentificatedUser).user),
          child: BlocConsumer<ActivityCubit, ActivityState>(
            listener: (BuildContext context, ActivityState state) {
              if (state is ActivityError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Une erreur est survenue lors du chargement des activités.'),
                  ),
                );
              }
            },
            builder: (BuildContext activityContext, ActivityState state) {
              if (state is ActivityLoading) {
                const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is ActivityLoaded) {
                return Scaffold(
                  backgroundColor: Colors.amber.shade50,
                  appBar: AppBar(
                    bottom: TabBar(
                      controller: _tabController,
                      tabs: tabs,
                    ),
                  ),
                  body: SafeArea(
                    child: TabBarView(
                      controller: _tabController,
                      children: tabs.map((Tab tab) {
                        return ListView.separated(
                          itemCount: tab.text == 'Tous' ? state.allActivities.length : state.userActivities.length,
                          padding: const EdgeInsets.all(15),
                          separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 10),
                          itemBuilder: (BuildContext context, int index) {
                            return GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => BlocProvider<ActivityCubit>.value(
                                    value: BlocProvider.of(activityContext),
                                    child: ActivityInfos(
                                      activity:
                                          tab.text == 'Tous' ? state.allActivities[index] : state.userActivities[index],
                                    ),
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
                                              tab.text == 'Tous'
                                                  ? state.allActivities[index].title
                                                  : state.userActivities[index].title,
                                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),

                                            const SizedBox(height: 5),

                                            // Date
                                            Text(
                                              DateFormat('dd/MM/y à HH:mm').format(
                                                tab.text == 'Tous'
                                                    ? state.allActivities[index].startDate
                                                    : state.userActivities[index].startDate,
                                              ),
                                            ),

                                            const SizedBox(height: 5),

                                            // Maximum attendees
                                            Text(
                                                '${tab.text == 'Tous' ? state.allActivities[index].attendees : state.userActivities[index].attendees} personnes'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                );
              }

              return Container();
            },
          ),
        );
      },
    );
  }
}

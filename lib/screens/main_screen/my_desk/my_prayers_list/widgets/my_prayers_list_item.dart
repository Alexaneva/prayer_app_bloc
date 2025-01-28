import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../bloc/my_desk/my_prayers_bloc/my_prayers_bloc.dart';
import '../../../../../bloc/my_desk/my_prayers_bloc/my_prayers_event.dart';
import '../../../../../bloc/my_desk/my_prayers_bloc/my_prayers_state.dart';
import '../../../../../models/prayer.dart';

class PrayerItem extends StatefulWidget {
  final Prayer prayer;

  const PrayerItem({super.key, required this.prayer});

  @override
  State<PrayerItem> createState() => _PrayerItemState();
}

class _PrayerItemState extends State<PrayerItem> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.prayer.prayerId.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        context
            .read<MyPrayersBloc>()
            .add(DeleteMyPrayer(widget.prayer.prayerId));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
        child: Container(
          height: 70,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 2),
                blurRadius: 6.0,
                spreadRadius: 1.0,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: ListTile(
              onTap: () {
                context.go('/prayersDetails/${widget.prayer.prayerId}/${Uri.encodeComponent(widget.prayer.title)}');
              },
              trailing: CircleAvatar(
                radius: 15,
                backgroundColor: Colors.grey.shade200,
                child: InkWell(
                  onTap: () {
                    context
                        .read<MyPrayersBloc>()
                        .add(UpdatePrayerColorEvent(widget.prayer));
                  },
                  child: Icon(Icons.handshake_sharp),
                ),
              ),
              leading: Builder(
                builder: (context) {
                  final colorState = context.watch<MyPrayersBloc>().state;
                  Color? color;
                  if (colorState is ColorIndicatorState) {
                    color = colorState.color;
                  } else {
                    color = null;
                  }
                  return Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    width: 23,
                  );
                },
              ),
              title: Text(widget.prayer.title),
            ),
          ),
        ),
      ),
    );
  }
}

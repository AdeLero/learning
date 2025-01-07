import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_learning/pantry/blocs/meal_time_bloc/meal_time_bloc.dart';
import 'package:my_learning/pantry/customization/theme_data.dart';
import 'package:my_learning/pantry/models/meal_time/meal_time_model.dart';
import 'package:my_learning/pantry/models/meal_time_enum.dart';

class MealTimeSettingsScreen extends StatelessWidget {
  const MealTimeSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mealTimeBloc = context.read<MealTimeBloc>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.canPop(context);
            mealTimeBloc.add(CloseSettings());
          },
          icon: Icon(Icons.arrow_back, color: pantryTheme.primaryColor),
        ),
        elevation: 3,
      ),
      body: BlocListener<MealTimeBloc, MealTimeState>(
        listener: (context, state) {
          if (state is MealTimeInitial) {
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<MealTimeBloc, MealTimeState>(
          builder: (context, state) {
            if (state is MealTimeInitial) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is MealTimeUpdateError) {
              return _buildErrorState(context, state.message);
            }

            if (state is MealTimeUpdated || state is MealTimeInitial) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'What Time is...',
                      style: TextStyle(fontWeight: FontWeight.w900, fontSize: 32),
                    ),
                    const SizedBox(height: 50),
                    ...(state as MealTimeUpdated).mealTimes.map((mealTimeSetting) {
                      return _buildMealTimeRow(
                        context,
                        mealTimeSetting,
                            (TimeOfDay time) {
                          // Dispatch an event to update the time for the selected meal
                          context.read<MealTimeBloc>().add(UpdateMealTime(
                            mealTime: mealTimeSetting.mealTime,
                            time: time,
                          ));
                        },
                      );
                    }).toList(),
                    const SizedBox(height: 100),
                    ElevatedButton(
                      onPressed: () {

                        final mealTimes = (state as MealTimeUpdated).mealTimes;
                        mealTimes.forEach((mealTimeSetting) {
                          mealTimeBloc.add(UpdateMealTime(
                            mealTime: mealTimeSetting.mealTime,
                            time: mealTimeSetting.time,
                          ));
                        });
                        Navigator.canPop(context);
                        mealTimeBloc.add(CloseSettings());
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.green),
                        fixedSize: MaterialStateProperty.all(const Size(320, 40)),
                      ),
                      child: const Text('Set Mealtimes'),
                    ),
                  ],
                ),
              );
            }

            return const Center(child: Text('Unknown state'));
          },
        ),
      ),
    );
  }

  Widget _buildMealTimeRow(BuildContext context, MealTimeSetting mealTimeSetting, Function(TimeOfDay) onTimeSelected) {
    final mealTimeBloc = context.read<MealTimeBloc>();
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            mealTimeSetting.mealTime.displayName,
            style: const TextStyle(fontSize: 24),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.lightGreen,
              border: Border.all(color: Colors.green),
            ),
            child: TextButton(
              onPressed: () async {
                final TimeOfDay? picked = await showTimePicker(
                  context: context,
                  initialTime: mealTimeSetting.time,
                );
                if (picked != null) {
                  // Updating the selected time
                  onTimeSelected(picked);
                  mealTimeBloc.add(UpdateMealTime(
                    mealTime: mealTimeSetting.mealTime,
                    time: picked,
                  ));
                }
              },
              child: Text(
                mealTimeSetting.time.format(context),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String errorMessage) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error,
              size: 48,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            Text(
              'Error: $errorMessage',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18, color: Colors.red),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Retry or handle the error
                context.read<MealTimeBloc>().add(UpdateMealTime(
                  mealTime: MealTime.breakfast, // Adjust this as needed
                  time: TimeOfDay.now(), // Replace with a valid TimeOfDay
                ));
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
              ),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

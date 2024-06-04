import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jc_recruit_app/bloc/food/food_bloc.dart';

class FoodSearchWidget extends StatelessWidget {
  const FoodSearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodBloc, FoodState>(
      builder: (context, state) {
        return TextField(
          onChanged: (value) =>
              context.read<FoodBloc>().add(SearchFoods(value)),
          style: TextStyle(
            color: Colors.white.withOpacity(0.87),
          ),
          decoration: InputDecoration(
            hintText: "Search food",
            hintStyle: TextStyle(
              color: Colors.white.withOpacity(0.75),
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white.withOpacity(0.75),
            ),
            filled: true,
            fillColor: Colors.white.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
          ),
        );
      },
    );
  }
}

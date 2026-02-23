import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hamro_bhagaicha_batch35d/features/dashbaord/presentation/state/saved_tip_state.dart';

final savedTipViewModelProvider =
    NotifierProvider<SavedTipViewModel, List<SavedTip>>(SavedTipViewModel.new);

class SavedTipViewModel extends Notifier<List<SavedTip>> {
  @override
  List<SavedTip> build() => [];

  bool isSaved(String tipId) {
    return state.any((tip) => tip.id == tipId);
  }

  void toggleTip(SavedTip tip) {
    if (isSaved(tip.id)) {
      state = state.where((savedTip) => savedTip.id != tip.id).toList();
      return;
    }
    state = [...state, tip];
  }
}

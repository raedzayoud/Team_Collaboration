import 'package:bloc/bloc.dart';
import 'package:collab_doc/feature/home/data/model/userdetails.dart';
import 'package:collab_doc/feature/home/data/repos/home_repos.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepos homeRepos;
  HomeCubit(this.homeRepos) : super(HomeInitial());

  Future<void> getUserDetails() async {
    try {
      emit(UserLoading());
      final result = await homeRepos.getUserDetails();
      result.fold(
        (failure) => emit(UserFailure(errorMessage: failure.errorMessage)),
        (userDetails) => emit(UserSuccess(userDetails: userDetails)),
      );
    } on Exception catch (e) {
      emit(UserFailure(errorMessage: "An Error Occured"));
    }
  }
}

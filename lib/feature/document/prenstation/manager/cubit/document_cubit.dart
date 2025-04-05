import 'package:bloc/bloc.dart';
import 'package:collab_doc/feature/document/data/repos/document_repos.dart';
import 'package:meta/meta.dart';

part 'document_state.dart';

class DocumentCubit extends Cubit<DocumentState> {
  final DocumentRepo documentRepos;
  DocumentCubit(this.documentRepos) : super(DocumentInitial());
  Future<void> summarizeText(String text) async {
    emit(DocumentLoading());

    try {
      var result = await documentRepos.summarizeText(text); // Use await here
      emit(DocumentSuccess(summary: result));
    } catch (error) {
      // Print or log the error to ensure it's being caught
      print('Error: $error');
      emit(DocumentFailure(errorMessage: error.toString()));
      // Delay before resetting to the initial state
      await Future.delayed(Duration(seconds: 4));
      emit(DocumentInitial());
    }
  }
}

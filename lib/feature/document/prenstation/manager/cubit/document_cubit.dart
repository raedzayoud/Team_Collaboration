import 'package:bloc/bloc.dart';
import 'package:collab_doc/feature/document/data/repos/document_repos.dart';
import 'package:meta/meta.dart';

part 'document_state.dart';

class DocumentCubit extends Cubit<DocumentState> {
  final DocumentRepo documentRepos;
  DocumentCubit(this.documentRepos) : super(DocumentInitial());
  Future<void> summarizeText(String text) async {
    emit(DocumentLoading());

    var result = documentRepos.summarizeText(text);

    result.then((value) {
      emit(DocumentSuccess(summary: value));
    }).catchError((error) {
      emit(DocumentFailure(errorMessage: error.toString()));
    });
  }
}

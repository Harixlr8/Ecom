import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_zybo/data/bloc/bloc_search/search_event.dart';
import 'package:test_zybo/data/bloc/bloc_search/search_state.dart';
import 'package:test_zybo/data/service/api_service.dart';


class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ApiService apiService;

  SearchBloc(this.apiService) : super(SearchInitial()) {
    on<SearchQueryChanged>(_onSearch);
  }

  Future<void> _onSearch(
    SearchQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    // print(event.query);

    try {
      final products = await apiService.searchProducts(event.query);
      emit(SearchSuccess(products));
    } catch (e) {
      emit(SearchFailure(e.toString()));
    }
  }
}

import 'package:get/get.dart';
import 'package:getx_mvvm/data/response/status.dart';
import 'package:getx_mvvm/models/home/random_quote_model.dart';
import 'package:getx_mvvm/repository/home_repo/home_repo.dart';

class RandomQuoteController extends GetxController {
  final repo = HomeRepo();

  final RxQuoteStatus = Status.LOADING.obs;
  final quote = RandomQuoteModel().obs;

  RxBool isLoading = false.obs;

  RxString error = ''.obs;
  RxSetRandomQuote(RandomQuoteModel _value) => quote.value = _value;
  RxSetQuoteStatus(Status _value) => RxQuoteStatus.value = _value;
  RxSetError(String _value) => error.value = _value;

  void fetchRandomQuote() {
    repo.randomQuoteApi().then((value) {
      RxSetQuoteStatus(Status.COMPLATED);
      RxSetRandomQuote(value);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      RxSetError(error.toString());
      RxSetQuoteStatus(Status.ERROR);
    });
  }

  void fetchNextRandomQuote() {
    isLoading = true.obs;
    // RxSetQuoteStatus(Status.LOADING);
    repo.randomQuoteApi().then((value) {
      RxSetQuoteStatus(Status.COMPLATED);
      isLoading = false.obs;
      RxSetRandomQuote(value);
    }).onError((error, stackTrace) {
      print(error);
      print(stackTrace);
      isLoading = false.obs;
      RxSetError(error.toString());
      RxSetQuoteStatus(Status.ERROR);
    });
  }
}

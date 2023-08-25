import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:ishihara_v1/models/test_plate.dart';
import 'package:ishihara_v1/repo/ishihara_repository.dart';

class IshiharaProvider extends ChangeNotifier {
  IshiharaProvider() {
    plates = IshiharaRepository().plates;
  }
  PageController controller = PageController();
  int _currentIndex = 0;
  int? currentChoice;
  bool get choiceSelected => currentChoice != null;

  int get plateNumber => _currentIndex;
  late List<TestPlate> plates;

  void nextPage() {
    controller.nextPage(
        duration: const Duration(milliseconds: 350), curve: Curves.linear);
  }

  void previousPage() {
    controller.previousPage(
        duration: const Duration(milliseconds: 350), curve: Curves.linear);
  }

  void setIndex(int index) {
    // if (!isFinished()) {
    currentChoice = null;
    _currentIndex = index;
    notifyListeners();
    // } else {
    //   if (index < _currentIndex) {
    //     currentChoice = null;
    //     _currentIndex = index;
    //     notifyListeners();
    //   }
    // }
  }

  TestPlate _getPlate() {
    return plates[_currentIndex];
  }

  String getPlateImage() {
    return _getPlate().imgPath;
  }

  String getPlateHint() {
    return _getPlate().hint;
  }

  int getPlateAnswer() {
    return _getPlate().answer;
  }

  void setChoice(int? index) async {
    currentChoice = index;
    notifyListeners();
  }

  bool isCorrect() {
    return currentChoice == getPlateAnswer();
  }

  List<String> _getOptions() {
    return _getPlate().options;
  }

  String getOption(int index) {
    return _getOptions()[index];
  }

  int getOptionsLength() {
    return _getOptions().length;
  }

  List<String> _getDescriptions() {
    return _getPlate().descriptions;
  }

  String? getDescription() {
    if (choiceSelected) {
      return _getDescriptions()[currentChoice!];
    }
    return null;
  }

  int getPlatesLength() {
    return plates.length;
  }

  void nextPlate() {
    if (!isFinished()) {
      currentChoice = null;
      _currentIndex++;
      notifyListeners();
    }
  }

  bool isFinished() {
    if (_currentIndex >= plates.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void reset() {
    setIndex(0);
    currentChoice = null;
    notifyListeners();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

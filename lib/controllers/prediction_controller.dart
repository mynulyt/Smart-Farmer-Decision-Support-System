import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smart_farmer/services/api_services.dart';

class PredictionController extends GetxController {
  // ========================
  // TEXT CONTROLLERS
  // ========================

  final nController = TextEditingController();
  final pController = TextEditingController();
  final kController = TextEditingController();

  final tempController = TextEditingController();
  final humidityController = TextEditingController();

  final phController = TextEditingController();
  final rainfallController = TextEditingController();

  final stateController = TextEditingController();
  final seasonController = TextEditingController();

  final areaController = TextEditingController();

  // ========================
  // OBS VARIABLES
  // ========================

  RxBool isLoading = false.obs;

  RxString recommendedCrop = ''.obs;

  RxString smartSuggestion = ''.obs;

  RxDouble estimatedYield = 0.0.obs;

  // ========================
  // PREDICT FUNCTION
  // ========================

  Future<void> predictCrop() async {
    try {
      isLoading.value = true;

      final response = await ApiService.predictCrop(
        n: double.parse(nController.text.trim()),

        p: double.parse(pController.text.trim()),

        k: double.parse(kController.text.trim()),

        temp: double.parse(tempController.text.trim()),

        humidity: double.parse(humidityController.text.trim()),

        ph: double.parse(phController.text.trim()),

        rainfall: double.parse(rainfallController.text.trim()),

        state: stateController.text.trim(),

        season: seasonController.text.trim(),

        area: double.parse(areaController.text.trim()),
      );

      if (response['status'] == 'success') {
        recommendedCrop.value = response['recommended_crop'];

        smartSuggestion.value = response['smart_suggestion'];

        estimatedYield.value = response['estimated_yield'].toDouble();
      } else {
        Get.snackbar("Error", response['message']);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

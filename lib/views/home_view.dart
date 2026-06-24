import 'dart:ui';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:smart_farmer/theme/app_color.dart';

import '../controllers/prediction_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final controller = Get.put(PredictionController());
  final List<String> seasons = [
    "Kharif",
    "Rabi",
    "Zaid",
    "Autumn",
    "Winter",
    "Summer",
    "Whole Year",
  ];
  final List<String> indianStates = [
    "Andhra Pradesh",
    "Arunachal Pradesh",
    "Assam",
    "Bihar",
    "Chhattisgarh",
    "Goa",
    "Gujarat",
    "Haryana",
    "Himachal Pradesh",
    "Jharkhand",
    "Karnataka",
    "Kerala",
    "Madhya Pradesh",
    "Maharashtra",
    "Manipur",
    "Meghalaya",
    "Mizoram",
    "Nagaland",
    "Odisha",
    "Punjab",
    "Rajasthan",
    "Sikkim",
    "Tamil Nadu",
    "Telangana",
    "Tripura",
    "Uttar Pradesh",
    "Uttarakhand",
    "West Bengal",
  ];
  Widget buildField({
    required String hint,
    required TextEditingController controller,
    required IconData icon,
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextField(
        controller: controller,

        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,

        inputFormatters: isNumber
            ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))]
            : [],

        style: const TextStyle(
          color: AppColors.textColor1,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),

        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColors.secondaryColor),

          hintText: hint,

          hintStyle: const TextStyle(
            color: AppColors.textColor2,
            fontWeight: FontWeight.w500,
          ),

          filled: true,
          fillColor: Colors.white.withOpacity(0.90),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(
              color: AppColors.borderColor.withOpacity(0.7),
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: AppColors.secondaryColor,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  void showResultPopup() {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.transparent,

        child: TweenAnimationBuilder(
          duration: const Duration(milliseconds: 500),
          tween: Tween<double>(begin: 0, end: 1),

          builder: (context, value, child) {
            return Transform.scale(
              scale: value,
              child: Opacity(opacity: value, child: child),
            );
          },

          child: ClipRRect(
            borderRadius: BorderRadius.circular(35),

            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),

              child: Container(
                padding: const EdgeInsets.all(25),

                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white.withOpacity(0.95),
                      AppColors.lightGreen.withOpacity(0.7),
                    ],

                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),

                  borderRadius: BorderRadius.circular(35),

                  border: Border.all(color: Colors.white54),
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),

                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primaryColor,
                      ),

                      child: const Icon(
                        Icons.eco,
                        size: 45,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Prediction Result",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textColor1,
                      ),
                    ),

                    const SizedBox(height: 25),

                    resultTile(
                      title: "Recommended Crop",
                      value: controller.recommendedCrop.value.toUpperCase(),
                      icon: Icons.grass,
                    ),

                    const SizedBox(height: 15),

                    resultTile(
                      title: "Estimated Yield",
                      value: "${controller.estimatedYield.value} Tons",
                      icon: Icons.bar_chart,
                    ),

                    const SizedBox(height: 15),

                    resultTile(
                      title: "AI Suggestion",
                      value: controller.smartSuggestion.value,
                      icon: Icons.tips_and_updates,
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 55,

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondaryColor,

                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),

                        onPressed: () {
                          Get.back();
                        },

                        child: const Text(
                          "Awesome",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget resultTile({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.65),
        borderRadius: BorderRadius.circular(20),
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Icon(icon, color: AppColors.secondaryColor),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                Text(
                  title,

                  style: const TextStyle(
                    color: AppColors.textColor2,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  value,

                  style: const TextStyle(
                    color: AppColors.textColor1,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,

      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4CAF50), Color(0xFF66BB6A), Color(0xFF1B5E20)],

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const SizedBox(height: 10),

                const Text(
                  "Smart Agriculture AI",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "AI Powered Crop Recommendation & Yield Prediction System",

                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),

                const SizedBox(height: 30),

                ClipRRect(
                  borderRadius: BorderRadius.circular(35),

                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),

                    child: Container(
                      padding: const EdgeInsets.all(22),

                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),

                        borderRadius: BorderRadius.circular(35),

                        border: Border.all(color: Colors.white24),
                      ),

                      child: Column(
                        children: [
                          buildField(
                            hint: "Nitrogen (N)",
                            controller: controller.nController,
                            icon: Icons.science,
                            isNumber: true,
                          ),

                          buildField(
                            hint: "Phosphorus (P)",
                            controller: controller.pController,
                            icon: Icons.biotech,
                            isNumber: true,
                          ),

                          buildField(
                            hint: "Potassium (K)",
                            controller: controller.kController,
                            icon: Icons.grass,
                            isNumber: true,
                          ),

                          buildField(
                            hint: "Temperature",
                            controller: controller.tempController,
                            icon: Icons.thermostat,
                            isNumber: true,
                          ),

                          buildField(
                            hint: "Humidity",
                            controller: controller.humidityController,
                            icon: Icons.water_drop,
                            isNumber: true,
                          ),

                          buildField(
                            hint: "PH Value",
                            controller: controller.phController,
                            icon: Icons.science_outlined,
                            isNumber: true,
                          ),

                          buildField(
                            hint: "Rainfall",
                            controller: controller.rainfallController,
                            icon: Icons.cloud,
                            isNumber: true,
                          ),

                          Padding(
                            padding: const EdgeInsets.only(bottom: 18),

                            child: DropdownSearch<String>(
                              items: (filter, loadProps) => indianStates,

                              selectedItem:
                                  controller.stateController.text.isEmpty
                                  ? null
                                  : controller.stateController.text,

                              popupProps: PopupProps.menu(
                                showSearchBox: true,

                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    hintText: "Search State",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),

                              decoratorProps: DropDownDecoratorProps(
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.location_on,
                                    color: AppColors.secondaryColor,
                                  ),

                                  hintText: "Select State",

                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.90),

                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 18,
                                  ),

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: AppColors.borderColor.withOpacity(
                                        0.7,
                                      ),
                                    ),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: AppColors.secondaryColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),

                              onSelected: (value) {
                                controller.stateController.text = value ?? "";
                              },
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 18),

                            child: DropdownSearch<String>(
                              items: (filter, loadProps) => seasons,

                              selectedItem:
                                  controller.seasonController.text.isEmpty
                                  ? null
                                  : controller.seasonController.text,

                              popupProps: PopupProps.menu(
                                showSearchBox: true,

                                searchFieldProps: TextFieldProps(
                                  decoration: InputDecoration(
                                    hintText: "Search Season",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),

                              decoratorProps: DropDownDecoratorProps(
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.calendar_month,
                                    color: AppColors.secondaryColor,
                                  ),

                                  hintText: "Select Season",

                                  filled: true,
                                  fillColor: Colors.white.withOpacity(0.90),

                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 18,
                                  ),

                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: AppColors.borderColor.withOpacity(
                                        0.7,
                                      ),
                                    ),
                                  ),

                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: const BorderSide(
                                      color: AppColors.secondaryColor,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),

                              onSelected: (value) {
                                controller.seasonController.text = value ?? "";
                              },
                            ),
                          ),

                          buildField(
                            hint: "Area",
                            controller: controller.areaController,
                            icon: Icons.square_foot,
                            isNumber: true,
                          ),

                          const SizedBox(height: 10),

                          Obx(() {
                            return SizedBox(
                              width: double.infinity,
                              height: 60,

                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.secondaryColor,

                                  elevation: 0,

                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),

                                onPressed: controller.isLoading.value
                                    ? null
                                    : () async {
                                        await controller.predictCrop();

                                        if (controller
                                            .recommendedCrop
                                            .value
                                            .isNotEmpty) {
                                          showResultPopup();
                                        }
                                      },

                                child: controller.isLoading.value
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,

                                        children: [
                                          Icon(
                                            Icons.auto_awesome,
                                            color: Colors.white,
                                          ),

                                          SizedBox(width: 10),

                                          Text(
                                            "Predict with AI",

                                            style: TextStyle(
                                              color: Colors.white,

                                              fontSize: 18,

                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/prediction_controller.dart';

class AppColors {
  static const Color primaryColor = Color(0xFFF6E31A);
  static const Color secondaryColor = Color(0xFF620A1E);
  static const Color borderColor = Color(0xFFA8A8A9);
  static const Color textFieldColor = Color(0xFFEFF0F7);
  static const Color textColor1 = Color(0xFF2B2B2B);
  static const Color textColor2 = Color(0xFF797777);
  static const Color redColor = Color(0xFFCC2655);
  static const Color whiteColor = Colors.white;
  static const Color greyColor = Color(0xFFEFF0F7);
  static const Color iconColor = Color(0xFF626262);
}

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final controller = Get.put(PredictionController());

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
          fontWeight: FontWeight.w500,
        ),

        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: AppColors.secondaryColor),

          hintText: hint,

          hintStyle: const TextStyle(
            color: AppColors.textColor2,
            fontWeight: FontWeight.w400,
          ),

          filled: true,

          fillColor: AppColors.whiteColor.withOpacity(0.70),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 18,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),

            borderSide: BorderSide(
              color: AppColors.borderColor.withOpacity(0.3),
            ),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),

            borderSide: const BorderSide(
              color: AppColors.secondaryColor,
              width: 1.5,
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
                      AppColors.whiteColor.withOpacity(0.85),

                      AppColors.primaryColor.withOpacity(0.55),
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

                      decoration: BoxDecoration(
                        shape: BoxShape.circle,

                        color: AppColors.primaryColor,
                      ),

                      child: const Icon(
                        Icons.eco,

                        size: 45,

                        color: AppColors.secondaryColor,
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
                            color: AppColors.whiteColor,

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
        color: Colors.white.withOpacity(0.55),

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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.primaryColor,

              AppColors.primaryColor.withOpacity(0.85),

              AppColors.secondaryColor,
            ],

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
                    color: AppColors.redColor,

                    fontSize: 30,

                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "AI Powered Crop Recommendation & Yield Prediction System",

                  style: TextStyle(
                    color: AppColors.secondaryColor,
                    fontSize: 15,
                  ),
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

                          buildField(
                            hint: "State",
                            controller: controller.stateController,
                            icon: Icons.location_on,
                          ),

                          buildField(
                            hint: "Season",
                            controller: controller.seasonController,
                            icon: Icons.calendar_month,
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

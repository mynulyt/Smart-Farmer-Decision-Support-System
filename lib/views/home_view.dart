import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../controllers/prediction_controller.dart';

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
      padding: const EdgeInsets.only(bottom: 16),

      child: TextField(
        controller: controller,

        keyboardType: isNumber
            ? const TextInputType.numberWithOptions(decimal: true)
            : TextInputType.text,

        inputFormatters: isNumber
            ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.]'))]
            : [],

        style: const TextStyle(color: Colors.white, fontSize: 16),

        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.white70),

          hintText: hint,

          hintStyle: const TextStyle(color: Colors.white70),

          filled: true,

          fillColor: Colors.white.withOpacity(0.12),

          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 20,
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),

            borderSide: BorderSide.none,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),

            borderSide: BorderSide(color: Colors.white24),
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(22),

            borderSide: const BorderSide(color: Colors.white, width: 1.5),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xfff6d365), Color(0xfffda085)],

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),

              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),

                child: Container(
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),

                    borderRadius: BorderRadius.circular(30),

                    border: Border.all(color: Colors.white24),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      const SizedBox(height: 20),

                      const Text(
                        "Smart Agriculture AI",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text(
                        "AI Powered Crop Recommendation & Yield Prediction",

                        style: TextStyle(color: Colors.white70),
                      ),

                      const SizedBox(height: 30),

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

                      const SizedBox(height: 20),

                      Obx(() {
                        return SizedBox(
                          width: double.infinity,

                          height: 55,

                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,

                              foregroundColor: Colors.orange,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),

                            onPressed: controller.isLoading.value
                                ? null
                                : () {
                                    controller.predictCrop();
                                  },

                            child: controller.isLoading.value
                                ? const CircularProgressIndicator()
                                : const Text(
                                    "Predict Now",

                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                          ),
                        );
                      }),

                      const SizedBox(height: 30),

                      Obx(() {
                        if (controller.recommendedCrop.value.isEmpty) {
                          return const SizedBox();
                        }

                        return Container(
                          width: double.infinity,

                          padding: const EdgeInsets.all(20),

                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),

                            borderRadius: BorderRadius.circular(25),
                          ),

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text(
                                "Recommended Crop: ${controller.recommendedCrop.value.toUpperCase()}",

                                style: const TextStyle(
                                  color: Colors.white,

                                  fontSize: 22,

                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                "Estimated Yield: ${controller.estimatedYield.value} tons",

                                style: const TextStyle(
                                  color: Colors.white70,

                                  fontSize: 18,
                                ),
                              ),

                              const SizedBox(height: 10),

                              Text(
                                controller.smartSuggestion.value,

                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

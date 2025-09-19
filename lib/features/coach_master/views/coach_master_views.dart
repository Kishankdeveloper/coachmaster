import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common_function/custom_snackbar.dart';
import '../../../common_function/widgets/datepicker.dart';
import '../../../common_function/widgets/decimalfield.dart';
import '../../../common_function/widgets/dropdown.dart';
import '../../../common_function/widgets/file_upload.dart';
import '../../../common_function/widgets/header.dart';
import '../../../common_function/widgets/text.dart';
import '../../../common_function/widgets/text_static.dart';
import '../controllers/coach_master_controller.dart';
import '../controllers/coach_master_dropdown_controller.dart';
import 'coach_cards_grid.dart';
import 'coarch_search_views.dart';

class CoachMasterView extends StatelessWidget {
  final CoachMasterController controller = Get.put(CoachMasterController());

  CoachMasterView({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          buildHeader(
            context,
            'Coach Details',
            Icons.directions_bus,
            false,
            false,
            null,
            null,
            null,
          ),
          // Main content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.search, color: Colors.white),
                      label: Column(
                        children: [
                          const Text(
                            "Search Coach Master",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Text(
                            "( Entire CMM )",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        elevation: 5,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        await Get.dialog(CoachSearchPopup());
                        // controller.refreshPlutoGrid();
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(child: CoachCardGrid()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FeedbackFormPopup extends StatefulWidget {
  const FeedbackFormPopup({super.key});

  @override
  State<FeedbackFormPopup> createState() => _FeedbackFormPopupState();
}

class _FeedbackFormPopupState extends State<FeedbackFormPopup> {
  final formKey = GlobalKey<FormState>();

  // Text Controllers
  final coachNoController = TextEditingController();
  final owningRlyController = TextEditingController();
  final coachTypeController = TextEditingController();
  final unitNoController = TextEditingController();
  final localCoachNoController = TextEditingController();
  final tareWeightController = TextEditingController();
  final kiloMeterEarnedController = TextEditingController();
  final kiloMeterEarnedPohController = TextEditingController();

  // Dropdowns using RxnString
  final utilityType = RxnString();
  final coachKind = RxnString();
  final coachCategory = RxnString();
  final powerGenType = RxnString();
  final propulsionType = RxnString();
  final propulsionMake = RxnString();
  final manufacturer = RxnString();
  final maintType = RxnString();
  final owningShed = RxnString();
  final maintShed = RxnString();
  final bioToilet = RxnString();
  final acFlag = RxnString();
  final cctvAvailable = RxnString();
  final maxSpeed = RxnString();
  final codalLife = RxnString();

  // Date Fields
  DateTime? commissioningDate;
  DateTime? builtDate;
  DateTime? condemnationDate;

  // image fields

  String? fileDataBase64ForEmuFrontImage,
      fileDataBase64ForEmuBackImage,
      fileDataBase64ForEmuEndPannelImage,
      fileDataBase64ForEmuBuiltPlateImage;
  String? frontImage, backImage, endPannelImage, builtPlateImage;

  bool _isSubmitting = false;
  Future<void> _selectDate(
    BuildContext context,
    String label,
    Function(DateTime) onSelected,
  ) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime(2100),
    );
    if (picked != null) onSelected(picked);
  }

  int count = 0;
  void setValue(
    CoachMasterController controller,
    CoachMasterDropDownData dropdownController,
  ) {
    coachNoController.text = controller.coachNo.value ?? '';
    owningRlyController.text = controller.owningRly.value ?? '';
    coachTypeController.text = controller.coachType.value ?? '';
    unitNoController.text = controller.unitNo.value;
    localCoachNoController.text = controller.localCoachNo.value;
    tareWeightController.text = controller.tareWeight.value;
    kiloMeterEarnedController.text = controller.kmEarnedBuilt.value;
    kiloMeterEarnedPohController.text = controller.kmEarnedLastPoh.value;

    // Assign dropdowns (RxnString to non-reactive)
    if (controller.utilityType.value != null &&
        controller.utilityType.value != '') {
      if (dropdownController.utilityType.contains(
        controller.utilityType.value,
      )) {
        utilityType.value = controller.utilityType.value;
      }
    }

    if (controller.coachKind.value != null &&
        controller.coachKind.value != '') {
      if (dropdownController.coachKind.contains(controller.coachKind.value)) {
        coachKind.value = controller.coachKind.value;
      }
    }

    coachCategory.value = controller.coachCategory.value;

    if (controller.powerGenType.value != null &&
        controller.powerGenType.value != '') {
      if (dropdownController.emuPowerGeneration.contains(
        controller.powerGenType.value,
      )) {
        powerGenType.value = controller.powerGenType.value;
      }
    }
    if (controller.propulsionType.value != null &&
        controller.propulsionType.value != '') {
      if (dropdownController.propulsionType.contains(
        controller.propulsionType.value,
      )) {
        propulsionType.value = controller.propulsionType.value;
      }
    }

    if (controller.propulsionMake.value != null &&
        controller.propulsionMake.value != '') {
      if (dropdownController.propulsionMake.contains(
        controller.propulsionMake.value,
      )) {
        propulsionMake.value = controller.propulsionMake.value;
      }
    }

    if (controller.manufacturer.value != null &&
        controller.manufacturer.value != '') {
      if (dropdownController.emuManufacturer.contains(
        controller.manufacturer.value,
      )) {
        manufacturer.value = controller.manufacturer.value;
      }
    }

    if (controller.maintType.value != null &&
        controller.maintType.value != '') {
      if (dropdownController.emuMaintType.contains(
        controller.maintType.value,
      )) {
        maintType.value = controller.maintType.value;
      }
    }

    if (controller.owningShed.value != null &&
        controller.owningShed.value != '') {
      if (dropdownController.emuShed.contains(controller.owningShed.value)) {
        owningShed.value = controller.owningShed.value;
      }
    }

    if (controller.maintShed.value != null &&
        controller.maintShed.value != '') {
      if (dropdownController.emuShed.contains(controller.maintShed.value)) {
        maintShed.value = controller.maintShed.value;
      }
    }
    var options = ['Y', 'N'];

    if (controller.bioToilet.value != null &&
        controller.bioToilet.value != '') {
      if (options.contains(controller.bioToilet.value)) {
        bioToilet.value = controller.bioToilet.value;
      }
    }

    if (controller.acFlag.value != null && controller.acFlag.value != '') {
      if (options.contains(controller.acFlag.value)) {
        acFlag.value = controller.acFlag.value;
      }
    }
    if (controller.cctvAvailable.value != null &&
        controller.cctvAvailable.value != '') {
      if (options.contains(controller.cctvAvailable.value)) {
        cctvAvailable.value = controller.cctvAvailable.value;
      }
    }

    if (controller.maxSpeed.value != null && controller.maxSpeed.value != '') {
      if (dropdownController.emuSpeed.contains(controller.maxSpeed.value)) {
        maxSpeed.value = controller.maxSpeed.value;
      }
    }

    if (controller.codalLife.value != null &&
        controller.codalLife.value != '') {
      if (dropdownController.emuCodalLife.contains(
        controller.codalLife.value,
      )) {
        codalLife.value = controller.codalLife.value;
      }
    }

    if (controller.commissioningDate.value != null &&
        controller.commissioningDate.value != '') {
      commissioningDate = controller.commissioningDate.value;
    }

    if (controller.builtDate.value != null &&
        controller.builtDate.value != '') {
      builtDate = controller.builtDate.value;
    }

    if (controller.condemnationDate.value != null &&
        controller.condemnationDate.value != '') {
      condemnationDate = controller.condemnationDate.value;
    }

    // Image fields
    // frontImage = controller.frontImage.value;
    // backImage = controller.backImage.value;
    // endPannelImage = controller.endPannelImage.value;
    // builtPlateImage = controller.builtPlateImage.value;
  }

  @override
  Widget build(BuildContext context) {
    final CoachMasterController controller = Get.find<CoachMasterController>();
    final CoachMasterDropDownData dropdownController = Get.find<CoachMasterDropDownData>();
    if (count == 0) {
      count++;
      setValue(controller, dropdownController);
    }
    var img1 = controller.fileDataBase64ForEmuFrontImage.value;
    var img2 = controller.fileDataBase64ForEmuBackImage.value;
    var img3 = controller.fileDataBase64ForEmuEndPannelImage.value;
    var img4 = controller.fileDataBase64ForEmuBuiltPlateImage.value;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.1,
        vertical: 40,
      ),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Add/Update Coach Details",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => dropdownController.isLoading.value
                      ? CircularProgressIndicator()
                      : Wrap(
                          spacing: 20,
                          runSpacing: 16,
                          children: [
                            CustomStaticField(
                              label: "Coach No",
                              value: controller.coachNo.value!,
                              isRequired: false,
                              width: 300,
                            ),

                            CustomStaticField(
                              label: "Owning Rly",
                              value: controller.owningRly.value!,
                              isRequired: false,
                              width: 300,
                            ),

                            CustomStaticField(
                              label: "Coach Type",
                              value: controller.coachType.value!,
                              isRequired: false,
                              width: 300,
                            ),

                            Obx(
                              () => CustomDropdownField(
                                label: "Utility Type",
                                isRequired: false,
                                value: utilityType.value,
                                onChanged: (v) =>
                                    utilityType.value = v as String?,
                                hintText: "Select",
                                items: dropdownController.utilityType
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                                width: 300,
                              ),
                            ),

                            Obx(
                              () => CustomDropdownField(
                                label: "Coach Kind",
                                isRequired: true,
                                value: coachKind.value,
                                onChanged: (v) =>
                                    coachKind.value = v as String?,
                                hintText: "Select",
                                items: dropdownController.coachKind
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                                width: 300,
                              ),
                            ),

                            CustomDropdownField(
                              label: "Coach Category",
                              isRequired: true,
                              value: coachCategory.value,
                              onChanged: (v) =>
                                  setState(() => coachCategory.value = v),
                              hintText: "Select",
                              items: ["MEMU", "EMU", "DEMU"]
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              width: 300,
                            ),

                            Obx(() => CustomSearchableDropdownField<String>(
                              label: 'Base Depot/Owning Shed',
                              isRequired: true,
                              width: 300,
                              options: dropdownController.emuShed.cast<String>().toList(),
                              itemLabel: (manufacturer) => manufacturer,
                              value: owningShed.value,
                              onChanged: (v) => setState(
                                    () => owningShed.value = v,
                              ),
                            )
                            ),

                            Obx(
                              () => CustomDropdownField(
                                label: "Power Generation Type",
                                isRequired: true,
                                value: powerGenType.value,
                                onChanged: (v) => setState(
                                  () => powerGenType.value = v as String?,
                                ),
                                hintText: "Select",
                                items: dropdownController.emuPowerGeneration
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                                width: 300,
                              ),
                            ),

                            Obx(
                              () => CustomDropdownField(
                                label: "Propulsion Type",
                                isRequired: true,
                                value: propulsionType.value,
                                onChanged: (v) => setState(
                                  () => propulsionType.value = v as String?,
                                ),
                                hintText: "Select",
                                items: dropdownController.propulsionType
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                                width: 300,
                              ),
                            ),

                            Obx(
                              () => CustomDropdownField(
                                label: "Propulsion Make",
                                isRequired: true,
                                value: propulsionMake.value,
                                onChanged: (v) => setState(
                                  () => propulsionMake.value = v as String?,
                                ),
                                hintText: "Select",
                                items: dropdownController.propulsionMake
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                                width: 300,
                              ),
                            ),

                         /*   CustomTextField(
                              label: "Unit No",
                              isRequired: false,
                              controller: unitNoController,
                              hintText: "unit number",
                              width: 300,
                              maxLength: 20,
                            ),*/

                            CustomTextField(
                              label: "Local Coach No",
                              isRequired: false,
                              controller: localCoachNoController,
                              hintText: "local coach number",
                              width: 300,
                              maxLength: 20,
                            ),

                            Obx(() => CustomSearchableDropdownField<String>(
                              label: 'Manufacturer',
                              isRequired: true,
                              width: 300,
                                options: dropdownController.emuManufacturer.cast<String>().toList(),
                                itemLabel: (manufacturer) => manufacturer,
                              value: manufacturer.value,
                              onChanged: (val) => setState(() => manufacturer.value = val as String)
                            )
                            ),

                            /*  Obx(
                              () => CustomDropdownField(
                                label: "Maint Type",
                                isRequired: true,
                                value: maintType.value,
                                onChanged: (v) => setState(
                                  () => maintType.value = v as String?,
                                ),
                                hintText: "Select",
                                items: dropdownController.emuMaintType
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                                width: 300,
                              ),
                            ),
                            */

                            /*     Obx(
                              () => CustomDropdownField(
                                label: "Maint Shed",
                                isRequired: true,
                                value: maintShed.value,
                                onChanged: (v) => setState(
                                  () => maintShed.value = v as String?,
                                ),
                                hintText: "Select",
                                items: dropdownController.emuShed
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(e),
                                      ),
                                    )
                                    .toList(),
                                width: 300,
                              ),
                            ),*/
                            // Dates
                            CustomDateField(
                              label: "Commissioning Date",
                              isRequired: true,
                              width: 300,
                              date: commissioningDate,
                              onTap: () => _selectDate(
                                context,
                                "Commissioning Date",
                                (d) {
                                  setState(() => commissioningDate = d);
                                },
                              ),
                            ),

                            CustomDateField(
                              label: "Built Date",
                              isRequired: true,
                              width: 300,
                              date: builtDate,
                              onTap: () =>
                                  _selectDate(context, "Built Date", (d) {
                                    setState(() => builtDate = d);
                                  }),
                            ),

                            CustomDateField(
                              label: "Condemnation Date",
                              isRequired: false,
                              width: 300,
                              date: condemnationDate,
                              onTap: () => _selectDate(
                                context,
                                "Condemnation Date",
                                (d) => setState(() => condemnationDate = d),
                              ),
                            ),

                            CustomDropdownField(
                              label: "Bio Toilet Available",
                              isRequired: true,
                              value: bioToilet.value,
                              onChanged: (v) =>
                                  setState(() => bioToilet.value = v),
                              hintText: "Select",
                              items: ["Y", "N"]
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              width: 300,
                            ),
                            CustomDropdownField(
                              label: "AC Flag",
                              isRequired: true,
                              value: controller.acFlag.value,
                              onChanged: (v) {
                                setState(() => acFlag.value = v);
                              },
                              hintText: "Select",
                              items: ["AC", "NON-AC"]
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              width: 300,
                            ),

                            CustomDropdownField(
                              label: "CCTV Available",
                              isRequired: true,
                              value: cctvAvailable.value,
                              onChanged: (v) =>
                                  setState(() => cctvAvailable.value = v),
                              hintText: "Select",
                              items: ["Y", "N"]
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              width: 300,
                            ),

                            CustomDecimalField(
                              label: "Tare Weight (Tons)",
                              isRequired: true,
                              maxLength: 10,
                              controller: tareWeightController,
                              hintText: "e.g. 43.25",
                              width: 300,
                            ),

                            /*CustomDropdownField(
                              label: "Max Speed (km/h)",
                              isRequired: true,
                              value: maxSpeed.value,
                              onChanged: (v) =>
                                  setState(() => maxSpeed.value = v as String?),
                              hintText: "Select",
                              items: dropdownController.emuSpeed
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              width: 300,
                            ),*/

                           /* CustomDropdownField(
                              label: "Codal Life (In Years)",
                              isRequired: true,
                              value: codalLife.value,
                              onChanged: (v) => setState(
                                () => codalLife.value = v as String?,
                              ),
                              hintText: "Select",
                              items: dropdownController.emuCodalLife
                                  .map(
                                    (e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ),
                                  )
                                  .toList(),
                              width: 300,
                            ),*/

                            CustomDecimalField(
                              label: "Built KM Earned",
                              isRequired: false,
                              controller: kiloMeterEarnedController,
                              hintText: "Built KM earned",
                              width: 300,
                              maxLength: 20,
                            ),

                            CustomDecimalField(
                              label: "Last POH KM Earned ",
                              isRequired: false,
                              controller: kiloMeterEarnedPohController,
                              hintText: "km since Last POH",
                              width: 300,
                              maxLength: 20,
                            ),

                            CustomFileUploadField(
                              label: "Coach No With Owning Rly",
                              width: 300,
                              isRequired: true,
                              existingImage: controller.fileDataBase64ForEmuFrontImage.value,
                              allowedExtensions: ['jpg', 'jpeg', 'png'],
                              onFileSelected: (base64, fileName) {
                                setState(() {
                                  fileDataBase64ForEmuFrontImage = base64;
                                  frontImage = fileName;
                                });
                              },
                            ),

                            CustomFileUploadField(
                              label: "Coach Type Image",
                              width: 300,
                              isRequired: false,
                              allowedExtensions: ['jpg', 'jpeg', 'png'],
                              existingImage: controller.fileDataBase64ForEmuBackImage.value,
                              onFileSelected: (base64, fileName) {
                                setState(() {
                                  fileDataBase64ForEmuBackImage = base64;
                                  backImage = fileName;
                                });
                              },
                            ),

                            CustomFileUploadField(
                              label: "Coach PRO Image",
                              width: 300,
                              isRequired: false,
                              allowedExtensions: ['jpg', 'jpeg', 'png'],
                              existingImage: controller.fileDataBase64ForEmuEndPannelImage.value,
                              onFileSelected: (base64, fileName) {
                                setState(() {
                                  fileDataBase64ForEmuEndPannelImage = base64;
                                  endPannelImage = fileName;
                                });
                              },
                            ),

                            CustomFileUploadField(
                              label: "Other Built Plate Image",
                              width: 300,
                              isRequired: false,
                              existingImage: controller.fileDataBase64ForEmuBuiltPlateImage.value,
                              allowedExtensions: ['jpg', 'jpeg', 'png'],
                              onFileSelected: (base64, fileName) {
                                setState(() {
                                  fileDataBase64ForEmuBuiltPlateImage = base64;
                                  builtPlateImage = fileName;
                                });
                              },
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 24),
                Wrap(
                  children: [
                    Text(
                      'Note* :- At least 1 images are required.',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.red,
                      ),
                      child: const Text("Cancel"),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _isSubmitting
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  _isSubmitting = true;
                                });

                                final data = {
                                  "coachId": controller.coachId.value ?? '',
                                  "coachNo": controller.coachNo.value ?? '',
                                  "owningRly": controller.owningRly.value ?? '',
                                  "coachType": controller.coachType.value ?? '',
                                  "utilityType": utilityType.value ?? '',
                                  "coachKind": coachKind.value ?? '',
                                  "coachCategory": coachCategory.value ?? '',
                                  "powerGenerationType": powerGenType.value ?? '',
                                  "propulsionType": propulsionType.value ?? '',
                                  "propulsionMake": propulsionMake.value ?? '',
                                  "unitNo": unitNoController.text,
                                  "localCoachNo": localCoachNoController.text,
                                  "manufacturer": manufacturer.value ?? '',
                                  "maintType": maintType.value ?? '',
                                  "baseDepot": owningShed.value ?? '',
                                  "maintShed": maintShed.value ?? '',
                                  "commissioningDate":
                                      commissioningDate?.toIso8601String() ??
                                      '',
                                  "builtDate":
                                      builtDate?.toIso8601String() ?? '',
                                  "condemnationDate":
                                      condemnationDate?.toIso8601String() ?? '',
                                  "isBiotoiletAvailable": bioToilet.value,
                                  "acFlag": acFlag.value == 'AC' ? 'Y' : 'N',
                                  "cctvAvailable": cctvAvailable.value,
                                  "tareWeight": tareWeightController.text,
                                  "maxSpeed": maxSpeed.value,
                                  "codalLife": codalLife.value,
                                  "kiloMeterEarned":
                                      kiloMeterEarnedController.text,
                                  "kiloMeterEarnedPoh":
                                      kiloMeterEarnedPohController.text,

                                  "fileDataBase64ForEmuFrontImage":
                                      fileDataBase64ForEmuFrontImage ?? '',

                                  "frontImage":
                                      frontImage != "" && frontImage != null
                                      ? 'emu_rail${convertSpacesToUnderscores(frontImage!)}'
                                      : '',

                                  "fileDataBase64ForEmuBackImage":
                                      fileDataBase64ForEmuBackImage ?? '',

                                  "backImage":
                                      backImage != "" && backImage != null
                                      ? 'emu_rail${convertSpacesToUnderscores(backImage!)}'
                                      : '',

                                  "fileDataBase64ForEmuEndPannelImage":
                                      fileDataBase64ForEmuEndPannelImage ?? '',

                                  "endPannelImage":
                                      endPannelImage != "" &&
                                          endPannelImage != null
                                      ? 'emu_rail${convertSpacesToUnderscores(endPannelImage!)}'
                                      : '',

                                  "fileDataBase64ForEmuBuiltPlateImage":
                                      fileDataBase64ForEmuBuiltPlateImage ?? '',

                                  "builtPlateImage":
                                      builtPlateImage != "" &&
                                          builtPlateImage != null
                                      ? 'emu_rail${convertSpacesToUnderscores(builtPlateImage!)}'
                                      : '',

                                  "status": "COMMISSIONED",
                                };
                                int imgCount = 0;
                                if ((frontImage != "" && frontImage != null) ||
                                    img1 != null) {
                                  imgCount++;
                                }
                                if ((backImage != "" && backImage != null) ||
                                    img2 != null) {
                                  imgCount++;
                                }
                                if ((endPannelImage != "" &&
                                        endPannelImage != null) ||
                                    img3 != null) {
                                  imgCount++;
                                }
                                if ((builtPlateImage != "" &&
                                        builtPlateImage != null) ||
                                    img4 != null) {
                                  imgCount++;
                                }
                                print(imgCount);
                                if (imgCount < 1) {
                                  showCustomSnackbar(
                                    'Atleast 1 image is required',
                                    bgColor: Colors.redAccent,
                                  );
                                  setState(() {
                                    _isSubmitting = false;
                                  });
                                  return;
                                }

                                Get.dialog(
                                  Center(child: CircularProgressIndicator()),
                                  barrierDismissible: false,
                                );

                                final finalData = data.map((key, value) {
                                  if (value == "") {
                                    return MapEntry(key, null);
                                  }
                                  return MapEntry(key, value);
                                });

                                controller.saveCoach(finalData);
                                setState(() {
                                  _isSubmitting = false;
                                });
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Save"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String convertSpacesToUnderscores(String input) {
    return input.replaceAll(' ', '_');
  }
}

import 'package:Hoppr/admin/controller/add_items_controller.dart';
import 'package:Hoppr/admin/layout_admin/widgets/my_button.dart';
import 'package:Hoppr/consts/app_colors.dart';
import 'package:Hoppr/consts/services/snack_bar_service.dart';
import 'package:Hoppr/consts/widget/custom_text_field.dart';
import 'package:Hoppr/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddItems extends ConsumerWidget {

   AddItems({super.key});

  final TextEditingController _nameController =TextEditingController();

  final TextEditingController _priceController =TextEditingController();

  final TextEditingController _sizeController =TextEditingController();

  final TextEditingController _discountpercentageController =TextEditingController();

  final TextEditingController _descriptionController =TextEditingController();
   // final formKey=GlobalKey<FormState>();
  @override
Widget build(BuildContext context, WidgetRef ref) {
    final supabase = Supabase.instance.client;
  final state = ref.watch(addItemProvider);
  final notifire = ref.read(addItemProvider.notifier);

  return Scaffold(
    backgroundColor: AppColors.lightScaffoldColor,
    appBar: AppBar(
      centerTitle: true,
      title: Text(
        "Add New Items",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
      ),
    ),
    body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: state.imagePath!= null?
                GestureDetector(
                  onTap: notifire.pickImage,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      state.imagePath!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ):state.isLoading?
                CircularProgressIndicator()
                    :GestureDetector(
                  onTap: notifire.pickImage,
                  child: const Icon(
                    Icons.camera_alt,
                    size: 30,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            Text(
              "Name",
              style: TextStyle(
                color:AppColors.darkScaffoldColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
              child: CustomTextField(
                controller: _nameController,
                hint: "Name",
                hintColor: AppColors.gray,
              ),
            ),
            Text(
              "Price",
              style: TextStyle(
                color: AppColors.darkScaffoldColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: CustomTextField(
                controller: _priceController,
                hint: "Price",
                hintColor: AppColors.gray,
              ),
            ),
            Text(
              "Size",
              style: TextStyle(
                color: AppColors.darkScaffoldColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: TextFormField(
                controller: _sizeController,
                decoration: InputDecoration(
                hintText: "Size",
                  hintStyle: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 16,
                    color: AppColors.gray,
                    fontWeight: FontWeight.w500,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: AppColors.gray,
                    ),
                  ),
                ),
                onFieldSubmitted:(value) {
                  notifire.addSize(value);
                  _sizeController.clear();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Wrap(
                spacing: 8,
                children: state.Size.map((size) =>Chip(
                  onDeleted: () => notifire.removeSize(size),
                    label: Text(size),
                ),
                ).toList(),
              ),
            ),
            SizedBox(height: 10,),
            Padding(
              padding:const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
              child: DropdownButtonFormField<String>(
                value: state.selectedCategory,
                  decoration: InputDecoration(
                      labelText: "Select Category",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(
                          color: AppColors.gray,
                          width: 1,
                        ),
                      ),
                  ),
                  items: state.category.map((String category){
                    return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),);
                  }).toList(),
                  onChanged: notifire.setSelectedCategory,
              ),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Checkbox(
                  value: state.isDiscounted,
                  onChanged: notifire.toggleDiscount,
                ),
                const Text("Apply Discount"),
              ],
            ),
            if(state.isDiscounted)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(
                  "Discount",
                  style: TextStyle(
                    color:AppColors.darkScaffoldColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                  child: CustomTextField(
                    controller: _discountpercentageController,
                    hint: "Discount Percentage",
                    hintColor: AppColors.gray,
                  ),
                ),
              ],
              ),
            Text(
              "Description",
              style: TextStyle(
                color:AppColors.darkScaffoldColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 15),
              child: CustomTextField(
                controller: _descriptionController,
                hint: "Description",
                hintColor: AppColors.gray,
                maxLines: 3,
              ),
            ),
            state.isLoading? Center(
              child: CircularProgressIndicator(),
            ):Center(
              child: MyButton(onTab: () async{
                try{
                  await notifire.uploadAndSaveItems(
                      _nameController.text,
                      _priceController.text,
                      _descriptionController.text,
                  );
                  // await notifire.
                  SnackBarService.showSuccessMessage('Items added successfully.');
                  navigatorKey.currentState!.pop();
                }catch(e){
                  SnackBarService.showErrorMessage('Error: $e');
                }
              },
                buttonText: "Save item",
                color: AppColors.primary,
              ),
            )
          ],
        ),
      ),
    ),
  );
}
}
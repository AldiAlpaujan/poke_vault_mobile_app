import 'package:poke_vault_mobile_app/config/theme/theme.dart';
import 'package:poke_vault_mobile_app/features/common/widget/app_bar_search.dart';
import 'package:poke_vault_mobile_app/features/common/widget/app_fix_btm_button.dart';
import 'package:poke_vault_mobile_app/features/common/widget/app_textfield_input.dart';
import 'package:poke_vault_mobile_app/shared/utils/validator_mixin.dart';
import 'package:flutter/material.dart';
import 'package:poke_vault_mobile_app/features/products/presentation/controllers/product_form.controller.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ProductFormPage extends GetView<ProductFormController>
    with ValidatorMixin {
  const ProductFormPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSearch(
        title: controller.product != null ? "Ubah Barang" : 'Tambah Barang',
        centerTitle: false,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Form(
                key: controller.formKey,
                child: Column(
                  spacing: 12,
                  children: [
                    AppTextFieldInput(
                      isRequired: true,
                      label: "Nama Barang",
                      hintText: 'Masukkan nama barang',
                      controller: controller.nameC,
                      validator: (v) => emptyValidator('Nama barang', v!),
                    ),
                    AppTextFieldInput(
                      isRequired: true,
                      readOnly: true,
                      label: "Kategori Barang",
                      hintText: 'Masukkan kategori barang',
                      controller: controller.categoryC,
                      validator: (v) => emptyValidator('Kategori barang', v!),
                      onTap: controller.pickCategory,
                      suffixIcon: Icon(
                        MdiIcons.unfoldMoreVertical,
                        color: AppTheme.capColor,
                      ),
                    ),
                    AppTextFieldInput(
                      isRequired: true,
                      isDropDown: true,
                      label: "Kelompok Barang",
                      hintText: 'Masukkan kelompok barang',
                      dropDownInitialValue: controller.groupC.text,
                      dropDownItems: controller.groups,
                      controller: controller.groupC,
                      validator: (v) =>
                          emptyValidator('Kelompok barang', v ?? ''),
                    ),
                    AppTextFieldInput(
                      isRequired: true,
                      numberOnly: true,
                      label: "Stok",
                      hintText: 'Masukkan stok',
                      controller: controller.stockC,
                      validator: (v) => emptyValidator('Stok', v!),
                    ),
                    AppTextFieldInput(
                      isRequired: true,
                      isCurrency: true,
                      label: "Harga",
                      hintText: 'Masukkan harga',
                      controller: controller.priceC,
                      onCurrencyChanged: (v) => controller.price = v,
                      validator: (v) => emptyValidator('Harga', v!),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AppFixBtmButton(onPressed: controller.onSubmit, label: 'Simpan'),
        ],
      ),
    );
  }
}


import 'package:crud_stadandri/app/widgets/form_field/form_input_field.dart';
import 'package:crud_stadandri/app/widgets/form_field/form_input_field_checkbox.dart';
import 'package:crud_stadandri/app/widgets/form_field/form_input_field_radios.dart';
import 'package:crud_stadandri/domain/entities/user.dart';
import 'package:flutter/material.dart';

import '../base_dialog.dart';

class UserCreateDialog extends StatefulWidget {
  final Function(User parent) onSave;

  const UserCreateDialog({Key? key, required this.onSave}) : super(key: key);

  @override
  State<UserCreateDialog> createState() => _UserCreateDialogState();
}

class _UserCreateDialogState extends State<UserCreateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _nameCon;
  late final TextEditingController _emailCon;
  late int _genderCon;
  late bool _statusCon;

  @override
  void initState() {
    _nameCon = TextEditingController();
    _emailCon = TextEditingController();
    _genderCon = -1;
    _statusCon = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: 'Tambah User',
      contents: [
        SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                FormInputField(
                  label: 'Nama',
                  controller: _nameCon,
                  inputType: TextInputType.text,
                  validator: (s) {
                    if (s == null || s.isEmpty) return 'Harus Diisi';
                    return null;
                  },
                ),
                FormInputField(
                  label: 'Email',
                  controller: _emailCon,
                  inputType: TextInputType.text,
                  validator: (s) {
                    if (s == null || s.isEmpty) return 'Harus Diisi';
                    return null;
                  },
                ),
                FormInputFieldRadios(
                  label: 'Gender',
                  value: _genderCon,
                  setState: (i) {
                    setState(() {
                      _genderCon = i;
                    });
                  },
                  contents: const ['Laki-Laki', 'Perempuan'],
                ),
                FormInputFieldCheckBox(
                  'Aktif',
                  _statusCon,
                  (val) => setState(() {
                    _statusCon = val;
                  }),
                ),
              ],
            ),
          ),
        ),
        BaseDialogActions(
          formKey: _key,
          onSave: () => widget.onSave(
            User(0, _nameCon.text, _emailCon.text, _genderCon==0 ? 'male' : 'female', _statusCon ? 'active' : 'inactive'),
          ),
        ),
      ],
    );
  }
}
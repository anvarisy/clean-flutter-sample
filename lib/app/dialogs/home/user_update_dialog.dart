
import 'package:crud_stadandri/app/widgets/form_field/form_input_field.dart';
import 'package:crud_stadandri/app/widgets/form_field/form_input_field_checkbox.dart';
import 'package:crud_stadandri/app/widgets/form_field/form_input_field_radios.dart';
import 'package:crud_stadandri/domain/entities/user.dart';
import 'package:flutter/material.dart';

import '../base_dialog.dart';

class UserUpdateDialog extends StatefulWidget {
  final Function(User parent) onSave;
  final User user;

  const UserUpdateDialog({Key? key, required this.onSave, required this.user}) : super(key: key);

  @override
  State<UserUpdateDialog> createState() => _UserUpdateDialogState();
}

class _UserUpdateDialogState extends State<UserUpdateDialog> {
  final _key = GlobalKey<FormState>();
  late final TextEditingController _idCon;
  late final TextEditingController _nameCon;
  late final TextEditingController _emailCon;
  late int _genderCon;
  late bool _statusCon;

  @override
  void initState() {
    _idCon = TextEditingController(text: widget.user.id.toString());
    _nameCon = TextEditingController(text: widget.user.name);
    _emailCon = TextEditingController(text: widget.user.email);
    _genderCon = widget.user.gender=='male' ? 0 : 1;
    _statusCon = widget.user.status=='active';
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
                  label: 'Id',
                  controller: _idCon,
                  isDisabled: true,
                ),
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
            User(widget.user.id, _nameCon.text, _emailCon.text, _genderCon==0 ? 'male' : 'female', _statusCon ? 'active' : 'inactive'),
          ),
        ),
      ],
    );
  }
}
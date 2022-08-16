import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/app/extensions/extensions.dart';
import 'package:hd_splash_flutter/app/locale/lang_code.dart';
import 'package:hd_splash_flutter/views/components/components.dart';
import 'package:hd_splash_flutter/views/edit_profile_user/edit_profile_user.dart';

class EditProfileUserPage extends StatelessWidget {
  const EditProfileUserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(context.lang(LangCode.editProfile)),
        actions: [
          IconButton(
              onPressed: () {
                context.read<EditProfileUserCubit>().updateProfileUser();
                FocusScope.of(context).unfocus();
              },
              icon: const Icon(Icons.done))
        ],
      ),
      body: BlocListener<EditProfileUserCubit, EditProfileUserState>(
        listener: (context, state) {
          switch (state.status) {
            case Status.complete:
              ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(context.lang(LangCode.updateSuccess)));
              break;
            case Status.err:
              ScaffoldMessenger.of(context).showSnackBar(
                  customSnackBar(context.lang(LangCode.updateFailed)));
              break;
            default:
              break;
          }
        },
        child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<EditProfileUserCubit, EditProfileUserState>(
                  buildWhen: (previous, current) =>
                      previous.username != current.username,
                  builder: (context, state) {
                    return CustomTextField(
                      labelText: context.lang(LangCode.username),
                      textDefault: state.username,
                      onChanged: (value) => context
                          .read<EditProfileUserCubit>()
                          .onChangeUsername(value),
                    );
                  },
                ),
                BlocBuilder<EditProfileUserCubit, EditProfileUserState>(
                  buildWhen: (previous, current) =>
                      previous.firstName != current.firstName,
                  builder: (context, state) {
                    return CustomTextField(
                      labelText: context.lang(LangCode.firstName),
                      textDefault: state.firstName,
                      onChanged: (value) => context
                          .read<EditProfileUserCubit>()
                          .onChangeFirstName(value),
                    );
                  },
                ),
                BlocBuilder<EditProfileUserCubit, EditProfileUserState>(
                  buildWhen: (previous, current) =>
                      previous.lastName != current.lastName,
                  builder: (context, state) {
                    return CustomTextField(
                      labelText: context.lang(LangCode.lastName),
                      textDefault: state.lastName,
                      onChanged: (value) => context
                          .read<EditProfileUserCubit>()
                          .onChangeLastName(value),
                    );
                  },
                ),
                BlocBuilder<EditProfileUserCubit, EditProfileUserState>(
                  buildWhen: (previous, current) =>
                      previous.email != current.email,
                  builder: (context, state) {
                    return CustomTextField(
                      labelText: "Email",
                      textDefault: state.email,
                      onChanged: (value) => context
                          .read<EditProfileUserCubit>()
                          .onChangeEmail(value),
                    );
                  },
                ),
                BlocBuilder<EditProfileUserCubit, EditProfileUserState>(
                  buildWhen: (previous, current) =>
                      previous.portfolioUrl != current.portfolioUrl,
                  builder: (context, state) {
                    return CustomTextField(
                      labelText: context.lang(LangCode.portfolioUrl),
                      textDefault: state.portfolioUrl,
                      onChanged: (value) => context
                          .read<EditProfileUserCubit>()
                          .onChangeUrl(value),
                    );
                  },
                ),
                BlocBuilder<EditProfileUserCubit, EditProfileUserState>(
                  buildWhen: (previous, current) =>
                      previous.instagramUsername != current.instagramUsername,
                  builder: (context, state) {
                    return CustomTextField(
                      labelText: context.lang(LangCode.instagramUsername),
                      textDefault: state.instagramUsername,
                      onChanged: (value) => context
                          .read<EditProfileUserCubit>()
                          .onChangeInstagramUsername(value),
                    );
                  },
                ),
                BlocBuilder<EditProfileUserCubit, EditProfileUserState>(
                  buildWhen: (previous, current) =>
                      previous.location != current.location,
                  builder: (context, state) {
                    return CustomTextField(
                      labelText: context.lang(LangCode.location),
                      textDefault: state.location,
                      onChanged: (value) => context
                          .read<EditProfileUserCubit>()
                          .onChangeLocation(value),
                    );
                  },
                ),
                BlocBuilder<EditProfileUserCubit, EditProfileUserState>(
                  buildWhen: (previous, current) => previous.bio != current.bio,
                  builder: (context, state) {
                    return CustomTextField(
                      labelText: context.lang(LangCode.bio),
                      textDefault: state.bio,
                      onChanged: (value) => context
                          .read<EditProfileUserCubit>()
                          .onChangeBio(value),
                    );
                  },
                )
              ],
            )),
      ),
    );
  }
}


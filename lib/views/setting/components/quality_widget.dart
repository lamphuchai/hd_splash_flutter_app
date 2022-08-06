import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hd_splash_flutter/logic/cubits/cubits.dart';
import 'package:hd_splash_flutter/views/setting/components/dialog_widget/load_quality_dialog.dart';

import 'item_block.dart';

class QualityWidget extends StatelessWidget {
  const QualityWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quality",
          style: textTheme.titleLarge,
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(16)),
          child: Column(
            children: [
              BlocBuilder<AppSettingCubit, AppSettingState>(
                buildWhen: (previous, current) =>
                    previous.loadQualityType != current.loadQualityType,
                builder: (context, state) {
                  return ItemBlock(
                    icon: const Icon(Icons.workspaces),
                    title: "Load Quality",
                    subtitle: state.loadQualityType.name,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: ((context) => LoadQualityDialog(
                                selectedValue:
                                    ValueNotifier(state.loadQualityType),
                                onChange: (type) => context
                                    .read<AppSettingCubit>()
                                    .changeLoadQualityType(type),
                              )));
                    },
                  );
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ItemBlock(
                icon: const Icon(Icons.download),
                title: "Download quality",
                subtitle: "Reqular",
                onTap: () {},
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 24,
        ),
      ],
    );
  }
}

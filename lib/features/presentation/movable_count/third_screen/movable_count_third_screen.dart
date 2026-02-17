import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../product/constants/app_dimensions.dart';
import '../../../../product/utils/dependency_injection.dart';
import '../../../../product/utils/show_error_message.dart';
import '../../../data/models/movable_count_model.dart';
import '../../../data/repository/corporate_repository.dart';
import '../../../widgets/app_button.dart';
import '../../../widgets/custom_error_text.dart';
import '../../../widgets/loading_indicator.dart';
import '../cubit/movable_active_page_cubit.dart';
import '../cubit/movable_count_cubit.dart';

class MovableCountThirdScreen extends StatefulWidget {
  const MovableCountThirdScreen({Key? key, required this.pageController}) : super(key: key);

  final PageController pageController;

  @override
  State<MovableCountThirdScreen> createState() => _MovableCountThirdScreenState();
}

class _MovableCountThirdScreenState extends State<MovableCountThirdScreen> {
  @override
  void initState() {
    context.read<MovableCountCubit>().getMovableCounts(
          context.read<MovableCountCubit>().selectedUnit!.id.toString(),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<MovableCountCubit, MovableCountState>(
          builder: (context, state) {
            if (state is MovableCountsInProgress) {
              return const Center(
                child: CustomLoadingIndicator(),
              );
            } else if (state is MovableCountsSuccess) {
              return SuccessBody(
                items: state.modelData.detay!,
              );
            } else if (state is MovableCountsFailed) {
              return Center(
                child: CustomErrorText(message: state.message),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        const Spacer(),
        AppButton(
          text: 'Tamamla',
          onPressed: () {
            widget.pageController.jumpToPage(1);
            context.read<MovableActivePageCubit>().changePage(1);
          },
        )
      ],
    );
  }
}

class SuccessBody extends StatelessWidget {
  const SuccessBody({Key? key, required this.items}) : super(key: key);

  final List<MovableCountDetail> items;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Dismissible(
          background: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          key: Key(items[index].id.toString()),
          onDismissed: (direction) async {
            items.removeAt(index);

            await getIt
                .get<CorporateRepository>()
                .deleteFixture(
                  items[index].id!.round().toString(),
                )
                .then(
              (value) {
                value.fold(
                  (l) => showErrorMessage(l.message),
                  (r) => context.read<MovableCountCubit>().getMovableCounts(
                        context.read<MovableCountCubit>().selectedUnit!.id.toString(),
                      ),
                );
              },
            );
          },
          child: Card(
            shadowColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: AppDimensions.buttonRadius,
            ),
            elevation: 10,
            child: ListTile(
              leading: Text(
                "${index + 1})",
                style: Theme.of(context).textTheme.titleSmall,
              ),
              title: Text(
                items[index].adi ?? "",
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(items[index].aciklama.toString()),
              trailing: Text(items[index].demirbasNo!.round().toString()),
            ),
          ),
        );
      },
    );
  }
}

// void demirbasSil(int _sayimID) async {
//   var response = await http.delete(Uri.parse(BaseClass.server + "/api/ayn/sayim/detay/" + _sayimID.toString()), headers: {
//     'Authorization': 'Bearer ' + BaseClass.token,
//   });

//   if (response.statusCode == 200) {
//   } else {}
// }

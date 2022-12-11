import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nursing_home_dexter/bloc/add_todo_bloc/add_todo_bloc.dart';
import 'package:nursing_home_dexter/main.dart';
import 'package:nursing_home_dexter/shared/app_constants/app_colors.dart';
import 'package:nursing_home_dexter/shared/widget/common_appbar.dart';
import 'package:nursing_home_dexter/shared/widget/custom_circle_progress.dart';
import 'package:nursing_home_dexter/ui/add_todo/select_filter.dart';

import '../../data/entity/enum.dart';
import '../../data/entity/todo_model.dart';
import '../../shared/widget/dexter_button.dart';
import '../../shared/widget/dexter_textfield.dart';

class AddTodoItemScreen extends StatefulWidget {
  static const routeName = "/AddTodoItemScreen";

  const AddTodoItemScreen({Key? key}) : super(key: key);

  @override
  State<AddTodoItemScreen> createState() => _AddTodoItemScreenState();
}

class _AddTodoItemScreenState extends State<AddTodoItemScreen> {
  AddTodoBloc? _bloc;

  AddTodoBloc get bloc => _bloc ??= AddTodoBloc();

  TodoModel model = TodoModel.empty();

  // String? task = "";

  final otherFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) {
          bloc.add(FetchDataEvent());
          return bloc;
        },
        child: Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: AddTaskButton(
              addTask: () {
                if (model.shiftTypeID != null &&
                    model.residenceID != null &&
                    model.taskTitle != null) {
                  bloc.add(AddTodo(model, bloc.selectedTaskTypeIndex == -1));
                } else
                  customFloatingSnackBar(
                      context: context, content: "Please fill all required data", isSuccess: false);
              },
            ),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          appBar: commonAppBar(context, "To do"),
          body: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
            ),
            child: BlocConsumer<AddTodoBloc, AddTodoState>(
              listener: (BuildContext context, state) {
                if (state is AddToDoSuccess) {
                  Navigator.of(context).pop(state.modelAdded);
                }
              },
              buildWhen: (previous, current) {
                return current is! UpdateAvailableTasks &&
                    current is! LoadingAddProgressState &&
                    current is! LoadingAddTodoState;
              },
              builder: (BuildContext context, state) {
                if (state is AddTodoInitial) {
                  return const CustomProgressIndicatorWidget(
                    color: AppColors.mainAppColor,
                    size: 80,
                  );
                } else {
                  return Column(
                    children: [
                      SelectInFilter(
                        initialValue: model.shiftTitle,
                        function: (val, index) {
                          Navigator.of(context).pop();
                          if (val != null) {
                            model.shiftID = val.getID();
                            model.shiftTypeID = bloc.shiftListForNurse![index].shiftType;
                            model.shiftTitle = val.getName();
                            bloc.add(UpdateTodoListEvent());
                          }
                        },
                        list: bloc.shiftListForNurse,
                        title: "Shift type",
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SelectInFilter(
                        function: (val, index) {
                          Navigator.of(context).pop();
                          if (val != null) {
                            model.residenceID = val.getID();
                            model.residenceName = val.getName();
                            model.residenceTitle = val.getName();
                            model.taskTitle = "";
                            bloc.add(ApplyTodoFilterEvent(
                                index: index, filterType: TodoFilterEnum.residentsName));
                          }
                          bloc.add(UpdateTodoListEvent());
                        },
                        initialValue: model.residenceTitle,
                        list: bloc.residenceList,
                        title: "Residence List ",
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      BlocBuilder<AddTodoBloc, AddTodoState>(
                        buildWhen: (previous, current) {
                          return current is UpdateAvailableTasks;
                        },
                        builder: (context, mState) {
                          if (mState is UpdateAvailableTasks) {
                            return Column(
                              children: [
                                SelectInFilter(
                                  function: (val, _) {
                                    Navigator.of(context).pop();
                                    if (val != null) {
                                      model.taskTitle = val.getName();
                                      bloc.selectedTaskTypeIndex = 0;
                                    } else {
                                      bloc.selectedTaskTypeIndex = -1;
                                      model.taskTitle = "";
                                      otherFocusNode.requestFocus();
                                    }
                                    bloc.add(UpdateTodoListEvent());
                                  },
                                  initialValue:
                                      bloc.selectedTaskTypeIndex == -1 ? "Other" : model.taskTitle,
                                  list: bloc.residenceList![bloc.selectedResidenceTypeIndex!]
                                      .residentsTasks,
                                  title: "Task Type",
                                  allowTextField: true,
                                ),
                                if (bloc.selectedTaskTypeIndex == -1)
                                  const SizedBox(
                                    height: 8,
                                  ),
                                if ((bloc.selectedTaskTypeIndex == -1))
                                  DexterTextFormField(
                                      hintText: null,
                                      focusNode: otherFocusNode,
                                      textFormFieldValue: (String? value) {
                                        model.taskTitle = value;
                                      },
                                      textFormFieldValidator: (dynamic value) {
                                        if (value == '') {
                                          return "Task is required.";
                                        }
                                        return null;
                                      },
                                      textInputType: TextInputType.emailAddress,
                                      isTextObscure: false),
                              ],
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    ],
                  );
                }
                // buildListener(state, context);
              },
            ),
          ),
        ));
  }
}

class AddTaskButton extends StatelessWidget {
  final Function() addTask;

  const AddTaskButton({
    Key? key,
    required this.addTask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTodoBloc, AddTodoState>(builder: (context, state) {
      return Container(
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(8),
        ),
        child: state is LoadingAddTodoState
            ? const CustomProgressIndicatorWidget(
                color: AppColors.mainAppColor,
              )
            : DexterButton(
                title: "Add task",
                onPress: addTask,
                textColor: Colors.white,
                color: Colors.red,
              ),
      );
    });
  }
}

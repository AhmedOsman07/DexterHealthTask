import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nursing_home_dexter/data/FirebaseRepo.dart';
import 'package:nursing_home_dexter/data/entity/nurses_model.dart';
import 'package:nursing_home_dexter/main.dart';
import 'package:nursing_home_dexter/shared/utils/user_singelton.dart';
import 'package:nursing_home_dexter/shared/widget/custom_circle_progress.dart';

import '../../bloc/home_bloc/home_bloc.dart';
import '../../data/entity/todo_model.dart';
import '../../shared/app_constants/app_colors.dart';
import '../add_todo/add_todo.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/HomeScreen";

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc? _bloc;

  HomeBloc get bloc => _bloc ??= HomeBloc();

  List<QueryDocumentSnapshot<TodoModel>>? list;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) {
          bloc.add(FetchingList());
          return bloc;
        },
        child: Scaffold(
          // backgroundColor: AppColors.mainAppColor,
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.mainAppColor,
            onPressed: _addActionItem,
            child: const Icon(
              Icons.add,
            ),
          ),
          // appBar: commonAppBar(context, "", shouldAddBack: false),
          body: SafeArea(
            child: BlocConsumer<HomeBloc, HomeState>(
              listener: (BuildContext context, state) {
                if (state is HomeSuccessMessage) {
                  customFloatingSnackBar(context: context, content: state.message);
                }
              },
              builder: (BuildContext context, state) {
                if (state is HomeInitial) {
                  return const CustomProgressIndicatorWidget(
                    color: AppColors.mainAppColor,
                    size: 80,
                  );
                } else if (state is HomeListFetched) {
                  if (state.shouldAppend) {
                    list!.addAll(state.list);
                  } else {
                    list = state.list;
                  }
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Welcome ${AppSingleton.getInstance.data!.name ?? ""}! ",
                                maxLines: 1,
                                style: const TextStyle(fontSize: 24, color: AppColors.textColor),
                              ),
                              RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      style: TextStyle(
                                        color: AppColors.textColor.withOpacity(0.8),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                      text: "Dexter helps you organise your shift tasks",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Container(
                              height: 50,
                              width: 50,
                              decoration: const BoxDecoration(
                                color: AppColors.mainAppColor,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.person,
                                size: 30,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    StreamBuilder<DocumentSnapshot<NurseModel>>(
                        stream: FirebaseRepo()
                            .nursesRef
                            .doc(AppSingleton.getInstance.user!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot == null || snapshot.data == null) return const SizedBox();
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 120,
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const Text("Completed"),
                                    Text("${snapshot.data!.data()!.completedTasks}"),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Container(
                                width: 120,
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const Text("Pending"),
                                    Text("${snapshot.data!.data()!.pendingTasks}"),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                    const SizedBox(
                      height: 12,
                    ),
                    const Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 18.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Action Items",
                            style: TextStyle(
                              color: AppColors.textColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                customFloatingSnackBar(
                                    context: context,
                                    content:
                                        "Feature of filtering between completed and pending tasks",
                                    isSuccess: false);
                              },
                              child: Icon(Icons.filter_list_rounded))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    body(),
                  ],
                );
                // buildListener(state, context);
              },
            ),
          ),
        ));
    // return ListView.builder(itemBuilder: itemBuilder);
  }

  body() {
    return Expanded(
      child: RefreshIndicator(
          onRefresh: () async {
            bloc.add(FetchingList());
            return;
          },
          child: list == null || list!.isEmpty
              ? const EmptyToDoList()
              : ListView.separated(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  itemBuilder: (context, index) {
                    return TodoItem(
                        key: ValueKey(list![index].data().id!), item: list![index].data());
                  },
                  itemCount: list!.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(color: Colors.grey);
                  },
                )),
    );
  }

  void _addActionItem() {
    Navigator.of(context).pushNamed(AddTodoItemScreen.routeName).then((value) {
      if (value != null) {
        bloc.add(FetchingList());

        // list!.add(QueryDocumentSnapshot<TodoModel>(value));
        // bloc.add(AddLocalTodo(value as TodoModel));
      }
    });
  }
}

class TodoItem extends StatefulWidget {
  final TodoModel item;

  const TodoItem({super.key, required this.item});

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> with TickerProviderStateMixin {
  bool completed = false;
  late AnimationController controller;
  late Animation animation;
  late TodoModel item;

  @override
  void initState() {
    super.initState();
    item = widget.item;
    if (item.state == "Completed") {
      completed = true;
    }
    controller = AnimationController(
      duration: const Duration(milliseconds: 225),
      vsync: this,
    );
    final CurvedAnimation curve = CurvedAnimation(parent: controller, curve: Curves.linear);
    animation = Tween(begin: 0.0, end: 1.0).animate(curve)..addListener(() => setState(() {}));
    controller.forward(from: 0.0);
  }

  _onTap() {
    item.state = "Completed";
    setState(() => completed = !completed);
    controller.forward(from: 0.0);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      transform: Matrix4.identity()..scale(animation.value, 1.0),
      padding: const EdgeInsets.fromLTRB(12, 4, 12, 4),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                if (item.state == "Pending") {
                  final bloc = BlocProvider.of<HomeBloc>(context);
                  bloc.add(SetToCompleteEvent(item.id!));
                  _onTap();
                }
              },
              child: Icon(
                item.state == "Pending" ? Icons.check_box_outline_blank : Icons.check_box,
                size: 30,
              )),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Patient name: ${item.residenceName!} ",
                      style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textColor.withOpacity(0.8),
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Text(
                  item.taskTitle!,
                  maxLines: 2,
                  style: TextStyle(
                      decoration: completed ? TextDecoration.lineThrough : TextDecoration.none,
                      color: completed ? AppColors.textColor.withOpacity(0.6) : AppColors.textColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class EmptyToDoList extends StatelessWidget {
  const EmptyToDoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: const <Widget>[
          Icon(Icons.list_sharp),
          Text(
            "You don't have any tasks.",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.textColor),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nursing_home_dexter/data/entity/selection_contract.dart';

import '../../shared/app_constants/app_colors.dart';

class SelectInFilter extends StatefulWidget {
  const SelectInFilter(
      {this.list,
      this.title,
      required this.function,
      this.initialValue,
      this.allowTextField = false});

  // final List<SelectionContract>? list;
  final List<SelectionContract>? list;

  final String? title;
  final bool? allowTextField;
  final String? initialValue;
  final Function(SelectionContract? val, int index) function;

  @override
  SelectInFilterState createState() => SelectInFilterState();
}

class SelectInFilterState extends State<SelectInFilter> {
  @override
  void initState() {
    super.initState();
  }

  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            _navigateAndDisplaySelection(context);
          },
          child: Container(
            height: 45,
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.borderColor,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(4)),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Text(
                      isEmptyInitialValue() ? (widget.title!) : widget.initialValue!,
                      style: TextStyle(
                        fontSize: 15,
                        color: isEmptyInitialValue() ? AppColors.borderColor : AppColors.textColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  const IconButton(
                    padding: EdgeInsets.all(8),
                    iconSize: 30,
                    color: Colors.black,
                    icon: Icon(
                      Icons.arrow_drop_down_outlined,
                    ),
                    onPressed: null,
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool isEmptyInitialValue() => (widget.initialValue == null || widget.initialValue!.isEmpty);

  _navigateAndDisplaySelection(BuildContext context) async {
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        shape: const RoundedRectangleBorder(
          borderRadius:
              BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12)),
        ),
        builder: (BuildContext context) {
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                      // color: AppColors.mPrimaryTextColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0))),
                  width: double.infinity,
                  child: const Text(
                    "Filter",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (BuildContext context, int index) {
                      return const Divider(color: Colors.grey);
                    },
                    itemBuilder: (ctx, index) {
                      return ListTile(
                          trailing: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child:
                                Icon(Icons.navigate_next_outlined, color: AppColors.mainAppColor),
                          ),
                          // dense: widget.list![index].getSubtitle() != null,
                          subtitle: widget.list![index].getSubtitle() != null
                              ? Text('${widget.list![index].getSubtitle()}')
                              : null,
                          // contentPadding: EdgeInsets.zero,
                          visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                          leading: Icon(
                            isEmptyInitialValue() ||
                                    widget.list![index].getName() != widget.initialValue
                                ? Icons.radio_button_unchecked_rounded
                                : Icons.check_circle,
                            color: AppColors.mainAppColor,
                          ),
                          title: Text(
                            widget.list![index].getName(),
                          ),
                          onTap: () => {widget.function(widget.list![index], index)});
                    },
                    itemCount: widget.list!.length),
                if (widget.allowTextField!) ...[
                  const Divider(color: Colors.grey),
                  ListTile(
                      trailing: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(Icons.navigate_next_outlined, color: AppColors.mainAppColor),
                      ),
                      // contentPadding: EdgeInsets.zero,
                      visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
                      leading: Icon(
                        isEmptyInitialValue() || "Other" != widget.initialValue
                            ? Icons.radio_button_unchecked_rounded
                            : Icons.check_circle,
                        color: AppColors.mainAppColor,
                      ),
                      title: const Text(
                        "Other",
                      ),
                      onTap: () {
                        widget.function(null, -1);
                      }),
                ]
                // ...widget.list!.map(
                //   (e) => ,
                // ),
              ],
            ),
          );
        });
  }
}

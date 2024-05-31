import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:restapp2/sourcedata/api.dart';
import 'package:restapp2/sourcedata/remote.dart';
import 'package:restapp2/repository/restaurant_repository.dart';
import 'package:restapp2/usecases/case_add_review.dart';
import 'package:restapp2/external/colors_setting.dart';
import 'package:restapp2/bloc/add_review_bloc.dart';
import 'package:restapp2/widgets/button.dart';
import 'package:restapp2/widgets/text_field.dart';

class ReviewAddView extends StatelessWidget {
  final String restaurantId;
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  final FocusNode _reviewFocusNode = FocusNode();

  ReviewAddView({required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddReviewBloc(
          addReviewUseCase: AddReviewUseCaseImpl(
              restaurantRepository: RestaurantRepository(
                  remoteDataSource: RemoteDataSourceImpl(
                      dio: Dio(BaseOptions(baseUrl: Api.baseUrl)))))),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorsSet.sage,
          iconTheme: IconThemeData(color: ColorsSet.white),
          title: Text(
            "Add Review",
            style: TextStyle(
                color: ColorsSet.white,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp),
          ),
        ),
        body: BlocListener<AddReviewBloc, AddReviewState>(
          listener: (context, state) {
            if (state is AddReviewSuccessState) {
              Navigator.pop(context);
            } else if (state is AddReviewFailedState) {
              errorMessage(context, "An error occurred please try again later");
            } else if (state is AddReviewNameEmptyState) {
              errorMessage(context, "Name cannot be empty");
            } else if (state is AddReviewReviewEmptyState) {
              errorMessage(context, "Review cannot be empty");
            }
          },
          child: ListView(
            children: [
              CTextField(
                  controller: _userNameController,
                  hint: "Your name",
                  onFieldSubmitted: (v) =>
                      FocusScope.of(context).requestFocus(_reviewFocusNode),
                  keyboardType: TextInputType.name),
              CTextField(
                controller: _reviewController,
                hint: "Your review",
                keyboardType: TextInputType.multiline,
                maxLines: null,
                focusNode: _reviewFocusNode,
              ),
              Padding(
                padding: EdgeInsets.all(16.w),
                child: BlocBuilder<AddReviewBloc, AddReviewState>(
                    builder: (context, state) {
                  if (state is AddReviewLoadingState) {
                    return Stack(
                      children: [
                        CButton(
                          borderRadius: 10.0,
                          text: "Add Review",
                          onTap: () => {},
                        ),
                        Center(
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                ColorsSet.sage3),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return CButton(
                      borderRadius: 10.0,
                      text: "Add Review",
                      onTap: () => BlocProvider.of<AddReviewBloc>(context).add(
                          AddReview(
                              restaurantId: restaurantId,
                              userName: _userNameController.text,
                              review: _reviewController.text)),
                    );
                  }
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void errorMessage(context, String message) {
    final _snackBar = SnackBar(
      duration: const Duration(seconds: 1),
      backgroundColor: Colors.red,
      content: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.sp,
          color: Colors.white,
        ),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(_snackBar);
  }
}

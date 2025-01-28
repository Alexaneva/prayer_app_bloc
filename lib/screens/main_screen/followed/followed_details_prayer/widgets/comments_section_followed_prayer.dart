import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../bloc/followed/followed_prayers_details/followed_prayers_details_bloc.dart';
import '../../../../../bloc/followed/followed_prayers_details/followed_prayers_details_event.dart';
import '../../../../../models/comments.dart';

class CommentSectionFollowedPrayer extends StatelessWidget {
  final TextEditingController commentController;
  final String prayerId;
  final List<Comment> comments;

  const CommentSectionFollowedPrayer({
    super.key,
    required this.commentController,
    required this.prayerId,
    required this.comments,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCommentInput(context),
        _buildCommentList(),
      ],
    );
  }

  Widget _buildCommentInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: commentController,
              decoration: const InputDecoration(hintText: 'Enter your comment'),
              onSubmitted: (value) => _submitComment(context, value),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward),
            onPressed: () {
              final comment = commentController.text;
              if (comment.isNotEmpty) {
                _submitComment(context, comment);
              }
            },
          ),
        ],
      ),
    );
  }

  void _submitComment(BuildContext context, String value) {
    if (value.isNotEmpty) {
      final int prayerIdInt = int.parse(prayerId);
      context.read<FollowedPrayerDetailBloc>().add(AddCommentF(value, prayerIdInt));
      commentController.clear();
    }
  }

  Widget _buildCommentList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return ListTile(
          title: Text(
            '${comment.user?.name} - ${DateFormat('yyyy-MM-dd').format(comment.date ?? DateTime.now())}',
          ),
          subtitle: Text(comment.body),
        );
      },
    );
  }
}
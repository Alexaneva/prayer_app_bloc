import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../bloc/my_desk/my_detail_prayer_bloc/my_detail_prayer_bloc.dart';
import '../../../../../bloc/my_desk/my_detail_prayer_bloc/my_detail_prayer_event.dart';
import '../../../../../models/comments.dart';

class CommentSection extends StatelessWidget {
  final TextEditingController commentController;
  final String prayerId;
  final List<Comment> comments;

  const CommentSection({
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
      context.read<MyPrayerDetailBloc>().add(AddComment(value, prayerIdInt));
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
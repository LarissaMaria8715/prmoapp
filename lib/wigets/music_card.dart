import 'package:flutter/material.dart';
import '../model/music_model.dart';
import 'package:url_launcher/url_launcher.dart';

import '../utils/colors.dart';

class MusicCard extends StatelessWidget {
  final Music music;

  const MusicCard({super.key, required this.music});

  void _openPreview() async {
    final uri = Uri.parse(music.previewUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(music.artworkUrl, width: 60, height: 60),
        ),
        title: Text(music.trackName, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(music.artistName),
        trailing: IconButton(
          icon: const Icon(Icons.play_circle_fill, color: AppColors.darkGray1, size: 32),
          onPressed: _openPreview,
        ),
      ),
    );
  }
}

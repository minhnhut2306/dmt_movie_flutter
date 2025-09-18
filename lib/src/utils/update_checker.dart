import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// URL tới version.json của bạn (đổi sang domain của bạn)
const String kVersionJsonUrl = 'https://server-chi-three-13.vercel.app/version.json';

/// So sánh version kiểu "1.0.2"
int _cmpVer(String a, String b) {
  List<int> pa = a.split('.').map((e) => int.tryParse(e) ?? 0).toList();
  List<int> pb = b.split('.').map((e) => int.tryParse(e) ?? 0).toList();
  while (pa.length < 3) pa.add(0);
  while (pb.length < 3) pb.add(0);
  for (int i = 0; i < 3; i++) {
    if (pa[i] != pb[i]) return pa[i].compareTo(pb[i]);
  }
  return 0;
}

/// Gọi ở lúc app mở để kiểm tra cập nhật
Future<void> checkForUpdate(BuildContext context) async {
  try {
    // Lấy version hiện tại từ app
    final info = await PackageInfo.fromPlatform();
    final current = info.version; // ví dụ "1.0.0"

    // Lấy version mới từ server
    final resp = await http.get(Uri.parse(kVersionJsonUrl));
    if (resp.statusCode != 200) return;
    final data = jsonDecode(resp.body) as Map<String, dynamic>;
    final latest = (data['version'] ?? '').toString();
    final url = (data['url'] ?? '').toString();
    final changelog = (data['changelog'] ?? '').toString();
    final force = (data['force'] ?? false) == true;

    if (latest.isEmpty || url.isEmpty) return;

    // Nếu latest > current → có bản mới
    if (_cmpVer(latest, current) > 0) {
      if (!context.mounted) return;
      await showDialog(
        context: context,
        barrierDismissible: !force, // nếu force=true, không cho tắt dialog
        builder: (_) => WillPopScope(
          onWillPop: () async => !force, // chặn nút back nếu force
          child: AlertDialog(
            title: Text('Có phiên bản mới $latest'),
            content: Text(
              (changelog.isEmpty)
                  ? 'Bạn đang dùng $current. Cập nhật để có trải nghiệm tốt hơn.'
                  : 'Bạn đang dùng $current.\n\nCó gì mới:\n$changelog',
            ),
            actions: [
              if (!force)
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Để sau'),
                ),
              FilledButton(
                onPressed: () async {
                  final uri = Uri.parse(url);
                  // đóng dialog trước khi mở link
                  if (!force) Navigator.pop(context);
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                },
                child: const Text('Cập nhật'),
              ),
            ],
          ),
        ),
      );
    }
  } catch (_) {
    // im lặng, không phá trải nghiệm người dùng
  }
}

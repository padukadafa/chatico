import 'package:auto_route/auto_route.dart';
import 'package:awesome_flutter_extensions/awesome_flutter_extensions.dart';
import 'package:chatico/common/utils/utils.dart';
import 'package:chatico/core/router/app_router.dart';
import 'package:chatico/data/data_sources/user_remote_data_source.dart';
import 'package:chatico/data/models/chat_room.dart';
import 'package:chatico/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

@RoutePage()
class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  bool _isFlashOn = false;
  bool _isLoading = false;
  String _lastUserUid = "";
  final MobileScannerController controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
  );
  @override
  Widget build(BuildContext context) {
    final scanWindow = Rect.fromCenter(
      center: MediaQuery.sizeOf(context).center(Offset.zero),
      width: 200,
      height: 200,
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Scanner"),
        actions: [
          IconButton(
            onPressed: () async {
              await controller.toggleTorch();
              setState(() {
                _isFlashOn = !_isFlashOn;
              });
            },
            icon: Visibility(
              visible: _isFlashOn,
              replacement: Icon(Icons.flash_on),
              child: Icon(Icons.flash_off),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(
            controller: controller,
            onDetect: (barcodes) async {
              if (_isLoading) {
                return;
              }
              for (var element in barcodes.barcodes) {
                if (element.rawValue?.startsWith('chaticouid:') ?? false) {
                  final uid = element.rawValue!.replaceFirst("chaticouid:", "");
                  if (uid == _lastUserUid) {
                    EasyLoading.dismiss();
                    return;
                  }
                  _isLoading = true;
                  EasyLoading.show();

                  _lastUserUid = uid;
                  final user = await getIt<UserRemoteDataSource>().getUser(uid);
                  if (user != null) {
                    await getIt<UserRemoteDataSource>().addFriend(user);
                    await controller.stop();
                    EasyLoading.dismiss();

                    context.router.popAndPush(
                      ChatRoute(
                        chatRoom: ChatRoom(
                          roomId: Utils.roomId(uid),
                          users: [user],
                        ),
                      ),
                    );
                    return;
                  }
                  EasyLoading.showError("User Not Found");
                  _isLoading = false;
                }
                EasyLoading.dismiss();
              }
            },
          ),
          CustomPaint(
            painter: ScannerOverlay(scanWindow: scanWindow),
          ),
        ],
      ),
    );
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    await controller.dispose();
  }
}

class ScannerOverlay extends CustomPainter {
  const ScannerOverlay({
    required this.scanWindow,
    this.borderRadius = 12.0,
  });

  final Rect scanWindow;
  final double borderRadius;

  @override
  void paint(Canvas canvas, Size size) {
    final backgroundPath = Path()
      ..addRect(
        Rect.fromCenter(
          center: scanWindow.center,
          width: 5000,
          height: 5000,
        ),
      );

    final cutoutPath = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          scanWindow,
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
          bottomLeft: Radius.circular(borderRadius),
          bottomRight: Radius.circular(borderRadius),
        ),
      );

    final backgroundPaint = Paint()
      ..color = Colors.black.withOpacity(0.5)
      ..style = PaintingStyle.fill;
    // ..blendMode = BlendMode.dstOut;

    final backgroundWithCutout = Path.combine(
      PathOperation.difference,
      backgroundPath,
      cutoutPath,
    );

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final borderRect = RRect.fromRectAndCorners(
      scanWindow,
      topLeft: Radius.circular(borderRadius),
      topRight: Radius.circular(borderRadius),
      bottomLeft: Radius.circular(borderRadius),
      bottomRight: Radius.circular(borderRadius),
    );

    canvas.drawPath(backgroundWithCutout, backgroundPaint);
    canvas.drawRRect(borderRect, borderPaint);
  }

  @override
  bool shouldRepaint(ScannerOverlay oldDelegate) {
    return scanWindow != oldDelegate.scanWindow ||
        borderRadius != oldDelegate.borderRadius;
  }
}

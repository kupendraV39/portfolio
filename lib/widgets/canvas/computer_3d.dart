// import 'package:flutter/material.dart';
// import 'package:model_viewer_plus/model_viewer_plus.dart';
// import '../../utils/responsive.dart';

// /// Replaces ComputersCanvas (Three.js) — renders the desktop PC GLTF model.
// /// Hidden on mobile (< 640px) to avoid performance issues, matching the
// /// original React behaviour (isMobile check in Computers.tsx).
// class Computer3D extends StatelessWidget {
//   const Computer3D({super.key});

//   @override
//   Widget build(BuildContext context) {
//     if (Responsive.isMobile(context)) {
//       // On mobile, show a simple gradient placeholder instead of 3D
//       return Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//             colors: [Color(0xFF1a0533), Color(0xFF050816)],
//           ),
//         ),
//         child: Center(
//           child: Icon(
//             Icons.computer,
//             size: 120,
//             color: Colors.white.withOpacity(0.15),
//           ),
//         ),
//       );
//     }

//     return const ModelViewer(
//       src: 'assets/models/desktop_pc/scene.gltf',
//       alt: 'A 3D model of a desktop computer',
//       autoRotate: false,
//       cameraControls: false,
//       disableZoom: true,
//       // Match the React camera position
//       cameraOrbit: '-225deg 70deg 2.5m',
//       backgroundColor: Colors.transparent,
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../../utils/responsive.dart';

class Computer3D extends StatelessWidget {
  const Computer3D({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(
          right: isMobile ? 0 : 80,
          left: isMobile ? 0 : 40,
        ),
        child: SizedBox(
          width: isMobile ? double.infinity : 400,
          height: isMobile ? 300 : 500,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/kupi.jpeg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

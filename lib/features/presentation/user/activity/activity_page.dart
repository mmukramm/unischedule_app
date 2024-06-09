import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:unischedule_app/core/theme/colors.dart';
import 'package:unischedule_app/core/theme/text_theme.dart';
import 'package:unischedule_app/core/utils/asset_path.dart';
import 'package:unischedule_app/features/presentation/widget/custom_app_bar.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    List data = [
      {
        "image": "sample.png",
        "title":
            "Kampus Merdeka Belajar Kampus Merdeka (MBKM) Program Kompetisi Kampus Merdeka (PKKM) 2023",
      },
      {
        "image": "sample.png",
        "title":
            "Kampus Merdeka Belajar Kampus Merdeka (MBKM) Program Kompetisi Kampus Merdeka (PKKM) 2023",
      },
      {
        "image": "sample.png",
        "title":
            "Kampus Merdeka Belajar Kampus Merdeka (MBKM) Program Kompetisi Kampus Merdeka (PKKM) 2023",
      },
      {
        "image": "sample.png",
        "title":
            "Kampus Merdeka Belajar Kampus Merdeka (MBKM) Program Kompetisi Kampus Merdeka (PKKM) 2023",
      },
      {
        "image": "sample.png",
        "title":
            "Kampus Merdeka Belajar Kampus Merdeka (MBKM) Program Kompetisi Kampus Merdeka (PKKM) 2023",
      },
      {
        "image": "sample.png",
        "title":
            "Kampus Merdeka Belajar Kampus Merdeka (MBKM) Program Kompetisi Kampus Merdeka (PKKM) 2023",
      },
      {
        "image": "sample.png",
        "title":
            "Kampus Merdeka Belajar Kampus Merdeka (MBKM) Program Kompetisi Kampus Merdeka (PKKM) 2023",
      },
    ];

    return Scaffold(
      appBar: const CustomAppBar(
        withBackButton: false,
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              "Daftar Kegiatan Aktif",
              style: textTheme.displaySmall!,
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: StaggeredGrid.count(
                crossAxisCount: 8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: List.generate(
                  data.length,
                  (index) => StaggeredGridTile.count(
                    crossAxisCellCount: 4,
                    mainAxisCellCount: 6,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(
                        color: scaffoldColor,
                      ),
                      child: Column(
                        children: [
                          AspectRatio(
                            aspectRatio: 12 / 11,
                            child: Image.asset(
                              AssetPath.getImages("sample.png"),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Text(
                            "Kampus Merdeka Belajar Kampus Merdeka (MBKM) Program Kompetisi Kampus Merdeka (PKKM) 2023",
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: textTheme.titleSmall!.copyWith(
                              color: primaryTextColor,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

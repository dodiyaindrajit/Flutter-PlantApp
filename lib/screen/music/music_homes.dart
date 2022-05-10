import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:platapp_flutter/screen/music/commons/player_buttons.dart';
import 'package:platapp_flutter/screen/music/imageFilter/generator.dart';

class MusicHomes extends StatefulWidget {
  const MusicHomes({Key? key}) : super(key: key);

  @override
  _MusicHomesState createState() => _MusicHomesState();
}

final List<String> photos = [
  photo1,
  photo2,
  photo3,
  photo4,
  photo5,
  photo6,
  photo7,
  photo8,
  photo9,
  photo10,
  photo11
];

const String photo1 =
    'https://iaa-network.com/wp-content/uploads/2021/03/Seychelles-arbitration-1.jpg';
const String photo2 = 'https://i.imgur.com/bmwGs4n.png';
const String photo3 =
    'https://media.tacdn.com/media/attractions-splice-spp-674x446/07/6f/f1/aa.jpg';
const String photo4 =
    'https://i.pinimg.com/originals/20/0b/95/200b95dfb2efa80d37479764a324b462.jpg';

const String photo5 =
    'https://assets.rappler.co/612F469A6EA84F6BAE882D2B94A4B421/img/CDCC3B2965FC403F94CD4F3B158F1788/image-2019-01-21-3.jpg';
const String photo6 = 'https://cdn.wallpapersafari.com/68/60/HgzJbQ.jpg';
const String photo7 = 'https://wallpaperaccess.com/full/3879268.jpg';
const String photo8 = 'https://wallpapercave.com/wp/wp2461878.jpg';
const String photo9 = 'https://wallpapercave.com/wp/gLCTnod.jpg';
const String photo10 =
    'https://c4.wallpaperflare.com/wallpaper/827/998/515/ice-cream-4k-in-hd-quality-wallpaper-preview.jpg';
const String photo11 = 'https://img5.goodfon.com/wallpaper/nbig/e/93/tort-malina-shokolad.jpg';

String photo = photo1;

int noOfPaletteColors = 4;

class _MusicHomesState extends State<MusicHomes> {
  late AudioPlayer _audioPlayer;

  List<Color> colors = [];
  List<Color> sortedColors = [];
  List<Color> palette = [];

  Color primary = Colors.blueGrey;
  Color primaryText = Colors.black;
  Color background = Colors.white;

  late Random random;
  Uint8List? imageBytes;

  @override
  void initState() {
    super.initState();
    random = Random();
    extractColors();

    _audioPlayer = AudioPlayer();

    _audioPlayer
        .setAudioSource(ConcatenatingAudioSource(children: [
      AudioSource.uri(Uri.parse(
          "https://archive.org/download/IGM-V7/IGM%20-%20Vol.%207/25%20Diablo%20-%20Tristram%20%28Blizzard%29.mp3")),
      AudioSource.uri(Uri.parse(
          "https://archive.org/download/igm-v8_202101/IGM%20-%20Vol.%208/15%20Pokemon%20Red%20-%20Cerulean%20City%20%28Game%20Freak%29.mp3")),
      AudioSource.uri(Uri.parse(
          "https://scummbar.com/mi2/MI1-CD/01%20-%20Opening%20Themes%20-%20Introduction.mp3")),
    ]))
        .catchError((error) {
      if (kDebugMode) {
        print("Error While Loading AudioSource $error");
      }
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      key: UniqueKey(),
      appBar: AppBar(
        backgroundColor: primary,
        actions: [
          IconButton(
              onPressed: () {
                extractColors();
              },
              icon: const Icon(Icons.refresh))
        ],
        title: Text(
          'Coloring',
          style: TextStyle(color: primaryText, letterSpacing: 1),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: palette.isEmpty
                ? null
                : LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: [0.01, 0.6, 1],
                    colors: [
                      palette.first.withOpacity(0.3),
                      palette[palette.length ~/ 2],
                      palette.last.withOpacity(0.9),
                    ],
                  )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              child: imageBytes != null && imageBytes!.length > 0
                  ? Image.memory(
                      imageBytes!,
                      fit: BoxFit.fill,
                    )
                  : const Center(child: const CircularProgressIndicator()),
              height: 300,
            ),
            const SizedBox(
              height: 10,
            ),
            PlayerButtons(_audioPlayer),
          ],
        ),
      ),
    );
  }

  Future<void> extractColors() async {
    colors = [];
    sortedColors = [];
    palette = [];
    imageBytes = null;

    setState(() {});

    noOfPaletteColors = random.nextInt(4) + 2;
    photo = photos[random.nextInt(photos.length)];

    imageBytes = (await NetworkAssetBundle(Uri.parse(photo)).load(photo)).buffer.asUint8List();

    colors = await compute(extractPixelsColors, imageBytes);
    setState(() {});
    sortedColors = await compute(sortColors, colors);
    setState(() {});
    palette = await compute(generatePalette, {keyPalette: colors, keyNoOfItems: noOfPaletteColors});
    primary = palette.last;
    primaryText = palette.first;
    background = palette.first.withOpacity(0.5);
    setState(() {});
  }

  Widget _getPalette() {
    return SizedBox(
      height: 50,
      child: palette.isEmpty
          ? Container(
              child: const CircularProgressIndicator(),
              alignment: Alignment.center,
              height: 100,
            )
          : ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: palette.length,
              itemBuilder: (BuildContext context, int index) => Container(
                color: palette[index],
                height: 50,
                width: 50,
              ),
            ),
    );
  }
}
